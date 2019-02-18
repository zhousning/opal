# == Schema Information
#
# Table name: trades
#
#  id         :integer          not null, primary key
#  min        :float            default(1.0), not null
#  max        :float            default(1.2), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Trade < ActiveRecord::Base

end
