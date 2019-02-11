# == Schema Information
#
# Table name: citrines
#
#  id         :integer          not null, primary key
#  count      :integer          default(0), not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Citrine < ActiveRecord::Base
  belongs_to :user
  has_many :consumes

  def add_count(value)
    update_attribute :count, (self.count + value) 
    update_attribute :total, (self.total + value)
  end

  def sub_count(value)
    update_attribute :count, (self.count - value) 
  end
end
