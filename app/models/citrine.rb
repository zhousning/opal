class Citrine < ActiveRecord::Base
  belongs_to :user

  def add_count(value)
    update_attribute :count, (self.count + value) 
  end

  def sub_count(value)
    update_attribute :count, (self.count - value) 
  end
end
