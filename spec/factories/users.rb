FactoryGirl.define do

  factory :user, class: User do
    password 'qwqwqwqw'
    password_confirmation 'qwqwqwqw'

    trait :current do
      name 'amit'
      email 'amit@vinsol.com'
    end

    trait :admin do
      name 'sawan'
      email 'sawan@vinsol.com'      
      admin true
    end

  end

end