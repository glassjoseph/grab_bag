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
    route '/home'
    owner
  end

  factory :binary, aliases: [:text_binary] do
    sequence :name do |n|
      "File##{n}"
    end
    extension 'txt'
    data File.open('spec/test.txt')

    factory :image_binary do
      extension 'jpg'
      data File.open('spec/test.jpg')
    end

    factory :unknown_content_type_binary do
      extension 'ummm'
      data "I'm a number!"
    end
  end
end
