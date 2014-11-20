#FIX: filename should be singular
FactoryGirl.define do

  factory :user, class: User do
    #FIX: Use better password
    password 'qwqwqwqw'
    password_confirmation 'qwqwqwqw'

    #FIX: You are not creating a trait here. This is just a normal user. We can move user creation to /support/user_helper.rb if you need them in multiple files
    #FIX: Use sequence to set unique name and email.
    trait :current do
      name 'amit'
      email 'amit@vinsol.com'
    end

    #FIX: Remove name and email from here. Keep admin here
    trait :admin do
      name 'sawan'
      email 'sawan@vinsol.com'      
      admin true
    end

  end

end