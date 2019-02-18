# == Schema Information
#
# Table name: sells
#
#  id         :integer          not null, primary key
#  price      :float            not null
#  count      :float            not null
#  status     :string           default("enable"), not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sell < ActiveRecord::Base
  belongs_to :user

  validates :price,        :numericality => {:greater_than => 0}
  validates :count,        :numericality => {:greater_than_or_equal_to => 5}

  def disable
    update_attribute :status, Setting.sells.disable
  end
end
