FactoryGirl.define do
  factory :order do
    user
    amount 200
    notes nil
    order_number nil

    trait :requested do
      aasm_state Order::REQUESTED
    end

    trait :processed do
      aasm_state Order::PROCESSED
    end

    trait :call_request do
      cr true
      requested_at { Time.now }
      order_receiver
    end
  end
end