# == Schema Information
#
# Table name: items
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  opened_on    :date
#  requested_by :text
#  draft        :boolean
#  request      :text
#  address      :text
#  ward         :string(255)
#  creator_id   :integer
#  updater_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  reference    :text
#

require 'spec_helper'

describe Item do

  before do
    @item = Item.new(number: "2012-0001", request: "This is a request", opened_on: "01/01/2012", requested_by: "requestors", ward: "1", precinct: "1", address:"1 Centre Street", creator_id: 1, updater_id: 1) 
    @user = User.new(id: 1, name: "Test User", email: "test@example.com", password: "foobar", password_confirmation: "foobar")
  end

  subject { @item }

  it { should respond_to(:number) }
  it { should respond_to(:opened_on) }
  it { should respond_to(:requested_by) }
  it { should respond_to(:draft) }
  it { should respond_to(:address) }
  it { should respond_to(:ward) }
  it { should respond_to(:precinct) }
  it { should respond_to(:creator_id) }
  it { should respond_to(:updater_id) }
  it { should respond_to(:creator) }
  it { should respond_to(:updater) }


  describe "when number is not present" do
    before { @item.number = " " }
    it { should_not be_valid }
  end

  describe "when number is too long" do
    before { @item.number = "a" * 21 }
    it { should_not be_valid }
  end

  describe "when number is already taken" do
    before do
      docket_item_with_same_name = @item.dup
      docket_item_with_same_name.save
    end

    it { should_not be_valid }
  end

  describe "when creator_id is not present" do
    before { @item.creator_id = " " }
    it { should_not be_valid }
  end

# Need a test for when docket item is updated and updater_id is not present.

# Need a test for testing docket item creator name.

# Need a test for testing docket item updater name.
    
end
