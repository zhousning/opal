# == Schema Information
#
# Table name: wares
#
#  id            :integer          not null, primary key
#  title         :string           default(""), not null
#  price         :float            default(0.0), not null
#  citrine_count :float            default(0.0), not null
#  freight       :float            default(0.0), not null
#  description   :text             default(""), not null
#  category      :string           default(""), not null
#  brand         :string           default(""), not null
#  status        :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Ware < ActiveRecord::Base
  has_many :trade_orders
  has_many :enclosures, :dependent => :destroy
  accepts_nested_attributes_for :enclosures, reject_if: :all_blank, allow_destroy: true

  def up
    update_attribute :status, Setting.wares.up 
  end

  def down
    update_attribute :status, Setting.wares.down 
  end

end
