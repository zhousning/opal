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

  validates :coin,        :numericality => {:greater_than => 0}

  def state
    if self.status == Setting.extract_cashes.pending
      Setting.extract_cashes.pending_title
    elsif self.status == Setting.extract_cashes.agree
      Setting.extract_cashes.agree_title
    elsif self.status == Setting.extract_cashes.disagree
      Setting.extract_cashes.disagree_title
    end
  end

  def agree
    update_attribute :status, Setting.extract_cashes.agree 
  end
  
  def disagree
    update_attribute :status, Setting.extract_cashes.disagree
  end
end
