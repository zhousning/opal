class Ware < ActiveRecord::Base
  has_many :enclosures, :dependent => :destroy
  accepts_nested_attributes_for :enclosures, reject_if: :all_blank, allow_destroy: true

  def up
    update_attribute :status, Setting.wares.up 
  end

  def down
    update_attribute :status, Setting.wares.down 
  end

end
