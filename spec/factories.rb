FactoryGirl.define do
  factory :user do
    sequence :name do |n|
      "Name ##{n}"
    end
    sequence :username do |n|
      "username#{n}"
    end
    status 'active'
    sequence :email do |n|
      "email#{n}@email.com"
    end
    phone '5555555555'

    factory :fb_user do
      sequence :fb_id do |n|
        n.to_s
      end
      token ENV['facebook_token']
      avatar_url 'https://socwork.wisc.edu/files/joe-glass-lg.jpg'
    end
  end
end
