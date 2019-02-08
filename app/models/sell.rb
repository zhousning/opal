# == Schema Information
#
# Table name: sells
#
#  id         :integer          not null, primary key
#  price      :float            default(0.0), not null
#  count      :float            default(0.0), not null
#  status     :string           default("enable"), not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sell < ActiveRecord::Base
  belongs_to :user

  def disable
    update_attribute :status, Setting.sells.disable
  end
end
