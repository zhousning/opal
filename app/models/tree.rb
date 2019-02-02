# == Schema Information
#
# Table name: trees
#
#  id         :integer          not null, primary key
#  name       :string
#  count      :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tree < ActiveRecord::Base
  belongs_to :user

  def add_count(value)
    update_attribute :count, (self.count + value) 
  end
end
