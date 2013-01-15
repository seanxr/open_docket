# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address1   :string(255)
#  address2   :string(255)
#  city       :string(255)
#  state      :string(255)
#  postal     :string(255)
#  geo        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  creator_id :integer
#  updater_id :integer
#

require 'spec_helper'

describe Site do

  before do
    @site = Site.new(name: "Newton City Hall", address1: "1000 Commonwealth Ave.", address2: "no second address",
                     city: "Newton", state: "MA", postal: "02459", geo: "123456")
  end


  subject { @site }

  it { should respond_to(:name) }
  it { should respond_to(:address1) }
  it { should respond_to(:address2) }
  it { should respond_to(:city) }
  it { should respond_to(:state) }
  it { should respond_to(:postal) }
  it { should respond_to(:geo) }
  it { should respond_to(:creator_id) }
  it { should respond_to(:updater_id) }

# Need tests for length of fields
# Need tests to validate postal
end
