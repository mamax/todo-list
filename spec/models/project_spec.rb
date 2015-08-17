require 'rails_helper'

describe Project do

  let(:user) { FactoryGirl.create(:user) }
  before { @project = user.projects.build(name: "Loripsum") }

  subject { @project }

  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  # its(:user) { should eq user }
  # its(:remember_token) { should_not be_blank }
  # it { expect(@project.user).should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @project.user_id = nil }
    it { should_not be_valid }
  end

  describe "when user_id is not present" do
    before { @project.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @project.name = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @project.name = "a" * 31 }
    it { should_not be_valid }
  end
end
