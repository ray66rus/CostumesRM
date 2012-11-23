FactoryGirl.define do
  factory :user do
    name      "John Smith"
    email     "johnsmith@foo.bar"
    password  "foobar"
    password_confirmation "foobar"
    user_type "admin"
  end
end
