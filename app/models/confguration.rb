# == Schema Information
#
# Table name: confgurations
#
#  id           :integer          not null, primary key
#  item_counter :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Confguration < ActiveRecord::Base
  attr_accessible :item_counter
end
