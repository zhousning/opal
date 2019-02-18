# == Schema Information
#
# Table name: pick_records
#
#  id         :integer          not null, primary key
#  number     :float
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PickRecord < ActiveRecord::Base
  belongs_to :user

end
