require 'rails_helper'
require 'spec_helper'

describe "Project pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "project creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a project" do
        before do
          click_button "Add TODO list"
          fill_in 'project_name', with: " "
        end
        expect { click_button "Save" }.not_to change(Project, :count)
      end

      describe "error messages" do
        after { click_button "Save" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        click_button "Add TODO list"
        fill_in 'project_name', with: "Lorepsum"
      end
      it "should create a project" do
        expect { click_button "Save" }.to change(Project, :count).by(1)
      end
    end
  end
end
