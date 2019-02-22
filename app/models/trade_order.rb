# == Schema Information
#
# Table name: trade_orders
#
#  id         :integer          not null, primary key
#  number     :string
#  price      :float
#  state      :string           default("opening"), not null
#  name       :string           not null
#  phone      :string           not null
#  address    :string           not null
#  wayno      :string
#  user_id    :integer
#  ware_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TradeOrder < ActiveRecord::Base
  belongs_to :user
  belongs_to :ware

  has_one :consume

  validates_presence_of :name, :phone, :address

  STATE = %w(opening pending paid departed completed canceled)
  #validates_inclusion_of :state, :in => STATE

  before_save :store_unique_number
  def store_unique_number
    unless self.number
      self.number = Time.now.to_i.to_s + "%04d" % [rand(10000)]
    end
  end

  #添加paid?和completed?等方法
  STATE.each do |state|
    define_method "#{state}?" do
      self.state == state
    end
  end

  def pend
    if opening?
      update_attribute :state, 'pending'
    end
  end

  #只在pending状态可以pay
  def pay
    if pending?
      add_plan    #业务逻辑，订单生效
      update_attribute :state, 'paid'
    end
  end

  def depart 
    if paid?
      update_attribute :state, 'departed'
    end
  end

  #只在pending和paid状态可以complete
  def complete
    if departed?
      update_attribute :state, 'completed'
      complete_plan
    end
  end

  #只在pending和paid状态可以cancel
  def cancel
    if pending? or paid? or departed?
      remove_plan if paid? || departed?  #业务逻辑，取消订单
      update_attribute :state, 'canceled'
    end
  end

  def complete_plan
    user = self.user
    ware = self.ware
    citrine = user.citrine
    citrine.add_count(ware.citrine_count)
    Consume.create(:category => Setting.consumes.category_buy_ware_citrine, :coin_cost => ware.citrine_count, :status => Setting.consumes.status_success, :citrine_id => citrine.id)
    if parent = user.parent
      cms = ware.price*Setting.systems.commission
      parent.account.add_commision(cms)
      Consume.create(:category => Setting.consumes.category_buy_commision, :coin_cost => cms, :status => Setting.consumes.status_success, :user_id => parent.id)
    end
  end

  def add_plan
    self.user.account.sub_coin(self.price)
  end

  def remove_plan
    self.user.account.add_coin(self.price)
    self.consume.destroy
  end

  def trade_order_state
    if self.state == Setting.trade_orders.opening
      Setting.trade_orders.opening_title
    elsif self.state == Setting.trade_orders.pending
      Setting.trade_orders.pending_title
    elsif self.state == Setting.trade_orders.paid
      Setting.trade_orders.paid_title
    elsif self.state == Setting.trade_orders.departed
      Setting.trade_orders.departed_title
    elsif self.state == Setting.trade_orders.completed
      Setting.trade_orders.completed_title
    elsif self.state == Setting.trade_orders.canceled
      Setting.trade_orders.canceled_title
    end
  end
end
