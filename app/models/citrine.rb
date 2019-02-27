# == Schema Information
#
# Table name: citrines
#
#  id         :integer          not null, primary key
#  count      :float            default(0.0), not null
#  total      :float            default(0.0), not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  level      :string           default("青铜茶主")
#

class Citrine < ActiveRecord::Base
  belongs_to :user
  has_many :consumes

  def add_count(value)
    update_attribute :count, (self.count + value) 
    update_attribute :total, (self.total + value)
    update_attribute :level, level_title 
  end

  def sub_count(value)
    update_attribute :count, (self.count - value) 
  end

  def level_title
    if 0 <= self.total && self.total < 500
      Setting.levels.bronze
    elsif 500 <= self.total && self.total < 2000  
      Setting.levels.silver
    elsif 2000 <= self.total && self.total < 10000  
      Setting.levels.gold
    elsif 10000 <= self.total && self.total < 50000  
      Setting.levels.platinum
    elsif 50000 <= self.total
      Setting.levels.diamond
    end
  end
end
