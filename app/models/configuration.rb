# == Schema Information
#
# Table name: configurations
#
#  id           :integer          not null, primary key
#  item_counter :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Configuration < ActiveRecord::Base
  attr_accessible :item_counter
end
