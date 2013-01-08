# == Schema Information
#
# Table name: committees
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  shortname   :string(255)
#  creator_id  :integer
#  updater_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Committee do

  before do
    @committee = Committee.new(name: "Example Committee", shortname: "Example", description: "Example description", creator_id: 1, updater_id: 1) 
    @user = User.new(id: 1, name: "Test User", email: "test@example.com", password: "foobar", password_confirmation: "foobar")
  end


  subject { @committee }

  it { should respond_to(:name) }
  it { should respond_to(:shortname) }
  it { should respond_to(:description) }
  it { should respond_to(:creator_id) }
  it { should respond_to(:updater_id) }
  it { should respond_to(:creator) }
  it { should respond_to(:updater) }

  describe "when name is not present" do
    before { @committee.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @committee.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when name is already taken" do
    before do
      committee_with_same_name = @committee.dup
      committee_with_same_name.name = @committee.name.upcase
      committee_with_same_name.save
    end

    it { should_not be_valid }
  end

  describe "when creator_id is not present" do
    before { @committee.creator_id = " " }
    it { should_not be_valid }
  end

# Need a test for when committee is updated and updater_id is not present.

# Need a test for testing committee creator name.

# Need a test for testing committee updater name.
    
end
