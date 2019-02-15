# == Schema Information
#
# Table name: extract_cashes
#
#  id         :integer          not null, primary key
#  coin       :float
#  status     :string           default("pending"), not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ExtractCash < ActiveRecord::Base
  belongs_to :user

  def agree
    update_attribute :status, Setting.extract_cashes.agree 
  end
  
  def agree
    update_attribute :status, Setting.extract_cashes.pending
  end
end
