#ensures that the Rake task has access to the local Rails environment, including the User model
# (and hence User.create!). Here create! is just like the create method, except it raises an exception
# (Section 6.1.4) for an invalid user rather than returning false. This noisier construction makes debugging
# easier by avoiding silent errors.

# With the :db namespace as in Listing 9.29, we can invoke the Rake task as follows:
#$ bundle exec rake db:reset
#$ bundle exec rake db:populate
#$ bundle exec rake test:prepare

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    #User.create!(name: "Example user", email: "example@railstutorial.org", password: "foobar", password_confirmation: "foobar")
    admin = User.create!(name: "Example User",
                         email: "example@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar",
                         admin: true)
    99.times do |n|
      name=Faker::Name.name
      email="example-#{n+1}@railstutorial.org"
      password="password"
      User.create!(name: name, email: email, password: password, password_confirmation: password)
    end
  end
end

