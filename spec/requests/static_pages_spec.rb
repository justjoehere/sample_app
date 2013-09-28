require 'spec_helper'

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
end