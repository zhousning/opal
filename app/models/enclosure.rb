class Enclosure < ActiveRecord::Base
  belongs_to :buyer
  belongs_to :bird

  mount_uploader :file, EnclosureUploader
end
