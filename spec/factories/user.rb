#FIX: filename should be singular
FactoryGirl.define do

  factory :user, class: User do
    #FIX: Use better password
    sequence :email do |n|
      "sawan#{n}@vinsol.com"
    end
    name "sawan"
    password 'vammertest'
    password_confirmation 'vammertest'

    # group

    #FIX: You are not creating a trait here. This is just a normal user. We can move user creation to /support/user_helper.rb if you need them in multiple files
    #FIX: Use sequence to set unique name and email.
    #FIX: Remove name and email from here. Keep admin here

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