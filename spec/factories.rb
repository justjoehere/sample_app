FactoryGirl.define do
  factory :user do
    #By passing the symbol :user to the factory command, we tell Factory Girl that
    # the subsequent definition is for a User model object.
    name     "Michael Hartl"
    email    "michael@example.com"
    password "foobar1"
    password_confirmation "foobar1"
  end
end