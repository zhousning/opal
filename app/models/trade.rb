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
#  start          :time             default(2000-01-01 09:00:00 +0800), not null
#  end            :time             default(2000-01-01 16:00:00 +0800), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Trade < ActiveRecord::Base

end
