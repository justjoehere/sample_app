require 'spec_helper'
require 'factory_girl_rails'

describe "AuthenticationPages" do
  subject { page }
  describe "signin page" do
    #puts signin_path
    before { visit signin_path }
    it { should have_content('Sign in') }
  end
  describe "with valid information" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      visit signin_path
      fill_in "Email",    with: user.email.upcase
      fill_in "Password", with: user.password
      click_button "Sign in"
    end
    it { should have_title(user.name) }
    it { should have_link('Profile',     href: user_path(user)) }
    it { should have_link('Sign out',    href: signout_path) }
    it { should_not have_link('Sign in', href: signin_path) }
  end

  describe "invalid signin" do
    before do
      visit signin_path
      #fill_in "Email",    with: " "
      #fill_in "Password", with: " "
      click_button "Sign in"
    end
    it { should have_selector('div.alert.alert-error', text: 'Invalid') }
    describe "then visit another page" do
      before { click_link "Home" }
      it { should_not have_selector('div.alert.alert-error') }
    end
  end
end


