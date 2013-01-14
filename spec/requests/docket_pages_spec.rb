require 'spec_helper'

describe "DocketPages" do

  subject { page }

  describe "create docket page" do
    before { visit new_docket_item_docket_path }

    it { should have_selector('h1',    text: 'Create docket') }
    it { should have_selector('title', text: full_title('Create docket')) }
  end
end
