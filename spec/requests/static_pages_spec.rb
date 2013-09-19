require 'spec_helper'
describe "Static pages" do
  let(:base_title) {"Ruby on Rails Tutorial Sample App"}
  describe "Help page" do
    it "should have the h1 Help" do
      visit '/static_pages/help'
      page.should have_selector('h1',:text=>'Help')
    end
    it "should have the title 'Help'" do
      visit '/static_pages/help'
      page.should have_title("#{base_title} | Help")
    end
    it "should not have a custom page title" do
      visit '/static_pages/help'
      assert(page.title!="#{base_title}","Found " + page.title + " looking for mismatch with #{base_title}")
    end
  end
  describe "Home page" do
    it "should have the h1 Home" do
      visit '/static_pages/home'
      page.should have_selector('h1',:text=>'Home')
    end
    it "should have the base title" do
      visit '/static_pages/home'
      page.should have_title("#{base_title}")
    end
    it "should not have a custom page title" do
      visit '/static_pages/home'
      expect(page).not_to have_title(' | Home')
    end
  end
  describe "About page" do
#    it "should have the content 'About Us'" do
#      visit '/static_pages/about'
#      page.should have_content('About Us')
#    end
    it "should have the h1 About Us" do
      visit '/static_pages/about'
      page.should have_selector('h1',:text=>'About Us')
    end
    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      page.should have_title("#{base_title} | About Us")
    end
  end
  describe "Contact page" do
    it "should have the h1 Contact" do
      visit '/static_pages/contact'
      page.should have_selector('h1',:text=>'Contact')
    end
    it "should have the title 'Contact'" do
      visit '/static_pages/contact'
      page.should have_title("#{base_title} | Contact")
    end
  end
end