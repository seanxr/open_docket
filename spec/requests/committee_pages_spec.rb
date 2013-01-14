require 'spec_helper'

describe "CommitteePages" do

  subject { page }

  describe "new page" do

    before { visit new_committee_path }

    it { should have_selector('h1',    text: 'New') }
    it { should have_selector('title', text: full_title('New')) }
  end

  describe "new committee" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    before { visit new_committee_path }

    let(:submit) { "Create committee" }

    describe "with invalid information" do
      it "should not create a committee" do
        expect { click_button submit }.not_to change(Committee, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name", with: "Example Committee"
      end

      it "should create a committee" do
        expect { click_button submit }.to change(Committee, :count).by(1)
      end
    end
  end
end

