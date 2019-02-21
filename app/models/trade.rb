# == Schema Information
#
# Table name: trades
#
#  id             :integer          not null, primary key
#  min            :float            default(1.0), not null
#  max            :float            default(1.2), not null
#  total_purchase :float            default(0.0), not null
#  price          :float            default(0.0), not null
#  volume         :float            default(0.0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Trade < ActiveRecord::Base

end
