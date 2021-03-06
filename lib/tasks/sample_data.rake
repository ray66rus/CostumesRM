namespace :db do
  desc "Full database with sample data"
  task populate: :environment do
    user = User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    user_type = 'admin'
    user.save
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      user_type = User::TYPE_TO_TYPE_NAME.keys[Random.rand(User::TYPE_TO_TYPE_NAME.length)]
      password = "password"
      user = User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
      user.user_type = user_type
      user.save
    end
  end
end
