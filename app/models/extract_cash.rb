class ExtractCash < ActiveRecord::Base
  belongs_to :user

  def agree
    update_attribute :status, Setting.extract_cashes.agree 
  end
  
  def agree
    update_attribute :status, Setting.extract_cashes.pending
  end
end
