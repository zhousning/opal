# == Schema Information
#
# Table name: sells
#
#  id         :integer          not null, primary key
#  price      :float
#  count      :float
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sell < ActiveRecord::Base
  belongs_to :user

end
