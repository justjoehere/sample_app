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
      let(:user) {User.find_by(email: "user@example.com")}
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirm Password", with: "foobar"
      end
      it "should redirect to show user page" do
        #before {click_button submit}
        click_button submit
        expect(page).to have_title("Example User")
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
          fill_in "Confirm Password", with: "foobar1"
          click_button submit  #see :submit assignment above
        end
        it {should have_content("Password confirmation doesn't match Password")}
      end
      describe "after submission - invalid email" do
        before do
          fill_in "Name",         with: "Example User"
          fill_in "Email",         with: "userexamplecom"
          fill_in "Password",     with: "foobar"
          fill_in "Confirm Password", with: "foobar"
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
      click_link "Sign out"
      expect(page).to have_link('Home')
      #expect(page).to have_link('Sign in')
    end
  end
  describe "edit" do
    let (:user) {FactoryGirl.create(:user)}
    before do
      sign_in (user)
      visit edit_user_path(user)
    end
    describe "page" do
      it {should have_content("Update your profile")}
      it {should have_title("Edit user")}
      it {should have_link('change', href: 'http://gravatar.com/emails')}
    end
    describe "with valid infomration" do
      let (:new_name) {"New Name"}
      let (:new_email) {"new@example.com"}
      before do
        fill_in "Name",with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end
      it {should have_title(new_name)}
      it {should have_selector('div.alert.alert-success')}
      it { should have_link('Sign out', href: signout_path)}
      specify {expect(user.reload.name).to eq new_name}
      specify {expect(user.reload.email).to eq new_email}
    end
    describe "with invalid information" do
      before {click_button "Save changes"}
      it {should have_content('error')}
    end
    describe "forbidden attributes" do
      let(:params) do
        { user: { admin: true, password: user.password,
                  password_confirmation: user.password } }
      end
      before do
        sign_in user, no_capybara: true
        patch user_path(user), params
      end
      specify { expect(user.reload).not_to be_admin }
    end
  end
  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
      visit users_path
    end
    it { should have_title('All users') }
    it { should have_content('All users') }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it "should have pagination" do
        #page.save_page
        should have_selector('ul.pagination')  #changed from div.pagination due to bootstrap paginiation gem change
      end
      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
          #page.save_page
        end
      end
    end
    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }

    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }

    describe "microposts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
    end
  end
end