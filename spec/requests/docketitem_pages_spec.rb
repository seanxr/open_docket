require 'spec_helper'

describe "DocketItem pages" do

  subject { page }

  describe "create docket item page" do
    before { visit new_docket_item_path }

    it { should have_selector('h1',    text: 'Create docket item') }
    it { should have_selector('title', text: full_title('Create docket item')) }
  end
end
