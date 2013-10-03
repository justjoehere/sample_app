require 'spec_helper'
require 'factory_girl_rails'
#describe "UserPages" do
#  describe "GET /user_pages" do
#    it "works! (now write some real specs)" do
#      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#      get user_pages_index_path
#"#{      response.status.should be(200)
#"    end
# end
#end
#require 'spec_helper'

describe "User pages" do
  subject { page }
  describe "visit signup page" do
    before { visit signup_path }
    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end
  describe "visit user profile page" do
    let!(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end
  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Create my account" }
    describe "with valid information" do
      let!(:user) {User.find_by(email: "user@example.com")}
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      it "should redirect to show user page" do
        #before {click_button submit}
        click_button submit
        expect(page).to have_title(user.name)
        expect(page).to have_selector('div.alert.alert-success', text: 'Welcome')
      end
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      #subject {page}
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }
        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
    describe "with invalid infomraiton" do
      let(:submit) { "Create my account" } #assigns the text to :submit
      before { visit signup_path }
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      describe "after submission - all blank" do
        before {click_button submit}  #see :submit assignment above
        it {should have_content('error')}
      end

      describe "after submission - only Name" do
        before do
          fill_in "Name",         with: "Example User"
          click_button submit  #see :submit assignment above
        end
        it {should have_content("Email is invalid ")}
        it {should have_content("Email can't be blank ")}
        it {should have_content("Password is too short")}
      end
      describe "after submission - only email" do
        before do
          fill_in "Email",         with: "user@example.com"
          click_button submit  #see :submit assignment above
        end
        it {should have_content("Name can't be blank")}
        it {should have_content("Password is too short")}
      end
      describe "after submission - mismatch password" do
        before do
          fill_in "Name",         with: "Example User"
          fill_in "Email",         with: "user@example.com"
          fill_in "Password",     with: "foobar"
          fill_in "Confirmation", with: "foobar1"
          click_button submit  #see :submit assignment above
        end
        it {should have_content("Password confirmation doesn't match Password")}
      end
      describe "after submission - invalid email" do
        before do
          fill_in "Name",         with: "Example User"
          fill_in "Email",         with: "userexamplecom"
          fill_in "Password",     with: "foobar"
          fill_in "Confirmation", with: "foobar"
          click_button submit  #see :submit assignment above
        end
        it {should have_content("Email is invalid")}
      end
    end
  end
  describe "-signin followed by signout" do
    let!(:user) { FactoryGirl.create(:user) }
    before do
      visit signin_path
      fill_in "Email",        with: user.email
      fill_in "Password",     with: user.password
      #page.save_page
      click_button "Sign in"
      #page.save_page
      click_link "Account"
      #page.save_page
    end
    it "and verify home and signout links" do
      expect(page).to have_link('Home')
      expect(page).to have_link('Sign out')
      #page.save_page
      click_link "Sign out"
      #This is NOT Working.  Getting ActionController::InvalidAuthenticityToken in SessionsController#destroy error
      #page.save_page
      #expect(page).to have_link('Home')
      #expect(page).to have_link('Sign in')
    end
  end
end