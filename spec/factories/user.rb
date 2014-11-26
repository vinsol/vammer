FactoryGirl.define do

  factory :user, class: User do
    sequence :email do |n|
      "sawan#{n}@vinsol.com"
    end
    name "sawan"
    password 'vammertest'
    password_confirmation 'vammertest'

    # group

    trait :admin do
      admin true
    end

    trait :confirmed do
      confirmed_at Time.now
    end

    trait :disabled do
      enabled false
    end

    trait :with_group do
    end

  end

end