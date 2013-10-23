require 'spec_helper'
require 'factory_girl_rails'

describe "Static pages" do
  #let(:base_title) {"Ruby on Rails Tutorial Sample App"}
  subject {page}
  describe "Help page" do
    before {visit help_path}
    it {should have_selector('h1',:text=>'Help')}
    it {should have_title(full_title('Help'))}
    it "should not have a custom page title" do
      assert(page.title!=full_title(''),"Found " + page.title + " looking for mismatch with " + full_title('Help'))
    end
  end
  describe "Home page" do
    before {visit home_path}
    it {should have_selector('h1',:text=>'Home')}
    it {should have_title(full_title(''))}
    it "should not have a custom page title" do
      expect(page).not_to have_title(' | Home')
    end
    it "should have the content 'Contact'" do
      expect(page).to have_content('Contact')
    end

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
       #page.should have_selector("section span", text: Micropost.pluralize(Micropost.count.to_s, "micropost"))
      end
      it "should display delete link for own posts" do
        user.feed.each do |item|
          expect(page).to have_link("delete")
        end
      end
    end

  end
  describe "About page" do
#    it "should have the content 'About Us'" do
#      visit '/static_pages/about'
#      page.should have_content('About Us')
#    end
    before {visit about_path}
    it {should have_selector('h1',:text=>'About Us')}
    it {should have_title(full_title('About Us'))}
  end
  describe "Contact page" do
    before {visit contact_path}
    it {should have_title(full_title('Contact'))}
    it "should have the content 'Contact'" do
      expect(page).to have_content('Contact')
    end
  end
  describe "Verify Header and Footer Links" do
    it "should have the right links on the layout" do
      visit root_path
      click_link "About"
      expect(page).to have_title(full_title('About Us'))
      click_link "Help"
      expect(page).to have_title(full_title('Help'))
      click_link "Contact"
      expect(page).to have_title(full_title('Contact'))
      click_link "Home"
      click_link "Sign up now!"
      expect(page).to have_title(full_title('Sign up'))
      click_link "sample app"
      expect(page).to have_title(full_title(''))
    end
  end
end