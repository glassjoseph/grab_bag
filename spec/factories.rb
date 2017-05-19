FactoryGirl.define do
  factory :user, aliases: [:owner] do
    sequence :name do |n|
      "Name ##{n}"
    end
    sequence :username do |n|
      "username#{n}"
    end
    sequence :fb_id do |n|
      n.to_s
    end
    status 'active'
    sequence :email do |n|
      "email#{n}@email.com"
    end
    phone '5555555555'
    token ENV['facebook_token']
    avatar_url 'https://socwork.wisc.edu/files/joe-glass-lg.jpg'
  end

  factory :folder do
    sequence :name do |n|
      "Factory Folder#{n}"
    end
    sequence :route do |n|
      "home/factory-folder#{n}"
    end
    owner
  end

  factory :binary do
    sequence :name do |n|
      "File##{n}"
    end
    content_type 'txt'
    data File.new('spec/test.txt')
  end
end
