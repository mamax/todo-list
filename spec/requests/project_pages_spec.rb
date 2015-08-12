require 'rails_helper'

describe "Project pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "project creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a project" do
        expect { click_button "Add todo list" }.not_to change(Project, :count)
      end

      describe "error messages" do
        before { click_button "Add todo list" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'project_name', with: "Lorepsum" }
      it "should create a project" do
        expect { click_button "Add todo list" }.to change(Project, :count).by(1)
      end
    end
  end
end
