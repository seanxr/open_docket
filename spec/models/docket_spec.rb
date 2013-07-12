# == Schema Information
#
# Table name: dockets
#
#  id             :integer          not null, primary key
#  item_id        :integer
#  committee_id   :integer
#  note           :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  creator_id     :integer
#  updater_id     :integer
#  as_of          :date
#  assigner_id    :integer
#  public_hearing :boolean
#

require 'spec_helper'

describe Docket do

  before do 
    @committee = Committee.new(name: "Example Committee", shortname: "Example", description: "Example description", creator_id: 1, updater_id: 1) 
    @item = Item.new(number: "2012-0001", request: "This is a request", opened_on: "01/01/2012", requested_by: "requestors", ward: "1", precinct: "1", address:"1 Centre Street", creator_id: 1, updater_id: 1) 
    @user = User.new(id: 1, name: "Test User", email: "test@example.com", password: "foobar", password_confirmation: "foobar")
    @user.save
    @item.save
    @committee.save
    @docket = @committee.ondocket!(@item, "Note")
  end

  subject { @docket }

  it { should be_valid }

  describe "docket methods" do   

    it { should respond_to(:item) }

    it { should respond_to(:committee) }

    its(:item) { should == @item }

    its(:committee) { should == @committee }

    it { should respond_to(:creator_id) }

    it { should respond_to(:updater_id) }

    it { should respond_to(:note) }

 end

  describe "when committee id is not present" do

    before { @docket.committee_id = nil }

    it { should_not be_valid }

  end

  describe "when docket item id is not present" do

    before { @docket.item_id = nil }

    it { should_not be_valid }

  end

end
