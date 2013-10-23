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
        make_users
        make_microposts
        make_relationships
      end
    end

    def make_users
      admin = User.create!(name:     "Example User",
                           email:    "example@railstutorial.org",
                           password: "foobar",
                           password_confirmation: "foobar",
                           admin: true)
      99.times do |n|
        name  = Faker::Name.name
        email = "example-#{n+1}@railstutorial.org"
        password  = "password"
        User.create!(name:     name,
                     email:    email,
                     password: password,
                     password_confirmation: password)
      end
    end

    def make_microposts
      users = User.all(limit: 6)
      50.times do
        content = Faker::Lorem.sentence(5)
        users.each { |user| user.microposts.create!(content: content) }
      end
    end

    def make_relationships
      users = User.all
      user  = users.first
      followed_users = users[2..50]
      followers      = users[3..40]
      followed_users.each { |followed| user.follow!(followed) }
      followers.each      { |follower| follower.follow!(user) }
end

