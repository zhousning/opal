# == Schema Information
#
# Table name: notices
#
#  id         :integer          not null, primary key
#  title      :string           default(""), not null
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Notice < ActiveRecord::Base

end
