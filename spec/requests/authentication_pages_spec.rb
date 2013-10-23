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
      #visit signin_path
      #fill_in "Email",    with: user.email.upcase
      #fill_in "Password", with: user.password
      #click_button "Sign in"

      # replaced the above by refactoring signing in
      # to spec_helper.rb and using that sign-in method
      sign_in (user)
    end
    it { should have_title(user.name) }
    it { should have_link('Profile',     href: user_path(user)) }
    it { should have_link('Sign out',    href: signout_path) }
    it { should_not have_link('Sign in', href: signin_path) }
    it {should have_link('Settings', href:edit_user_path(user))}
    it { should have_link('Users',       href: users_path) }
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
  describe "authorization" do
    describe "for non-signed in users" do
      let(:user) {FactoryGirl.create(:user)}
      describe "in the Users controller" do
        describe "visiting the edit page" do
          #if not authorized in, then redirect to sign in page
          before do
            visit edit_user_path(user)
            #page.save_page
          end

          it {should have_title ('Sign in')}
        end
        describe "submitting the update action" do
          before do
            patch user_path(user)
            #page.save_page
          end

          specify {expect(response).to redirect_to(signin_path)}
        end
        describe "visitiing the user index" do
          before do
            visit users_path
            #page.save_page
          end
          it {should have_title('Sign in')}
        end
      end
      describe "in the Microposts controller" do

        describe "submitting to the create action" do
          before { post microposts_path }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete micropost_path(FactoryGirl.create(:micropost)) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end

    end
    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
    describe "for non-signed-in users" do
      let(:user) {FactoryGirl.create(:user)}
      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end
        describe "after singing in" do
          it "should render the desired protected page" do
            expect(page).to have_title('Edit user')
          end
        end
      end
    end
    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end

    describe "when attempting to visit a protected page" do
      #Friendly redirect governs wher ethe user lands after signing in
      #based on what they visted prior to signing in
      #first test validates redirected back to edit user after signing in
      #second test validates no prior path, so go to profile page (the default)
      let(:user) { FactoryGirl.create(:user) }
      before do
        visit edit_user_path(user)
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end
      describe "after signing in" do
        it "should render the desired protected page" do
          #page.save_page
          expect(page).to have_title('Edit user')
        end
        describe "when signing in again" do
          before do
            visit user_path(user)
            page.save_page
            click_link "Sign out"
            visit signin_path
            fill_in "Email",    with: user.email
            fill_in "Password", with: user.password
            click_button "Sign in"
          end
          it "should render the default (profile) page" do
            page.save_page
            expect(page).to have_title(user.name)
          end
        end
      end
    end
  end
end


