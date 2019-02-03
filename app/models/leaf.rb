# == Schema Information
#
# Table name: leafs
#
#  id         :integer          not null, primary key
#  pick       :integer          default(0), not null
#  unpick     :integer          default(0), not null
#  count      :float            default(0.0), not null
#  status     :integer          default(0), not null
#  pick_time  :datetime
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Leaf < ActiveRecord::Base
  belongs_to :user

  def add_pick(value)
    update_attributes(:pick => (self.pick + value), :pick_time => Time.now, :unpick => 0)
  end

  def add_unpick(value)
    update_attribute :unpick, (self.unpick + value) 
  end

  def add_count(value)
    update_attribute :count, (self.count + value) 
  end

  def add_pick_time
    update_attribute :pick_time, Time.now 
  end

  def enable
    update_attribute :status, Setting.leafs.enable 
  end

  def disable
    update_attribute :status, Setting.leafs.disable 
  end
end
