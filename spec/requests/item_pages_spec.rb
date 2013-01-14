require 'spec_helper'

describe "DocketItem pages" do

  subject { page }

  describe "create docket item page" do
    before { visit new_item_path }

    it { should have_selector('h1',    text: 'Create docket item') }
    it { should have_selector('title', text: full_title('Create docket item')) }
  end

  describe "new docket item" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }


    before { visit new_item_path }

    let(:submit) { "Create docket item" }

    describe "with invalid information" do
      it "should not create a docket item" do
        expect { click_button submit }.not_to change(Item, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Number", with: "2012-0001"
      end

      it "should create a docket item" do
        expect { click_button submit }.to change(Item, :count).by(1)
      end
    end
  end
end

