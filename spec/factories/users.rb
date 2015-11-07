FactoryGirl.define do
  factory :user do
    first_name 'Irfan'
    last_name 'Ahmed'
    sequence :email do |n|
      "person-#{n}@example.com"
    end
    password 'passw0rd'

    role User::CUSTOMER

    trait :collector do
      role User::COLLECTOR
    end
  end
end