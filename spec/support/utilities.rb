def full_title(page_title)
  base_title = "Ruby on Rails Tutorial Sample App"
  page_title.empty? ? base_title : "#{base_title} | #{page_title}"
end
RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end