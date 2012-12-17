FactoryGirl.define do
  factory :user do
    sequence(:name)      { |n| "John Smith #{n}" }
    sequence(:email)     { |n| "johnsmith_#{n}@foo.bar" }
    password  "foobar"
    password_confirmation "foobar"
    sequence(:user_type) { |n| User::TYPE_TO_TYPE_NAME.keys[n % User::TYPE_TO_TYPE_NAME.length] }
  
    factory :admin do
      user_type 'admin'
    end
    
    factory :poweruser do
      user_type 'poweruser'
    end
  end
end
