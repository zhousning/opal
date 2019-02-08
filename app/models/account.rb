# == Schema Information
#
# Table name: accounts
#
#  id          :integer          not null, primary key
#  coin        :float            default(0.0), not null
#  freeze_coin :float            default(0.0), not null
#  status      :string           default("disable"), not null
#  password    :string           default(""), not null
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Account < ActiveRecord::Base
  belongs_to :user

  def add_coin(value)
    self.update_attribute :coin, (self.coin + value)
  end

  def sub_coin(value)
    self.update_attribute :coin, (self.coin - value)
  end

  def add_freeze_coin(value)
    self.update_attribute :freeze_coin, (self.freeze_coin + value)
  end

  def sub_freeze_coin(value)
    self.update_attribute :freeze_coin, (self.freeze_coin - value)
  end
end
