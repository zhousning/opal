# == Schema Information
#
# Table name: share_pools
#
#  id            :integer          not null, primary key
#  today_enter   :float
#  total         :float
#  user_total    :float
#  pay           :float
#  ware_total    :float
#  gross_sale    :float
#  diamond       :float
#  current_total :float
#  own_tea       :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class SharePool < ActiveRecord::Base

end
