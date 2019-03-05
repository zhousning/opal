# == Schema Information
#
# Table name: tea_prices
#
#  id         :integer          not null, primary key
#  price      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TeaPrice < ActiveRecord::Base
end
