# == Schema Information
#
# Table name: demands
#
#  id         :integer          not null, primary key
#  price      :float            not null
#  count      :float            not null
#  status     :string           default("enable"), not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Demand < ActiveRecord::Base
  has_one    :consume, :dependent => :destroy
  belongs_to :user

  validates :price,        :numericality => {:greater_than => 0}
  validates :count,        :numericality => {:greater_than_or_equal_to => 5}

  def disable
    update_attribute :status, Setting.demands.disable
  end
end
