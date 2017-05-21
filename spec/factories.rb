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

    factory :user_with_folders do
      after(:create) do |user|
        3.times do
          user.home.folders << create(:folder, parent: user.home)

          user.home.binaries << create(:binary, folder: user.home)
        end
      end
    end
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
      "File#{n}"
    end
    extension 'txt'
    data_url 'https://textfiles.com/100/914bbs.txt'

    factory :image_binary do
      extension 'jpg'
      data_url 'http://i.imgur.com/nBYOnvl.jpg'
    end

    factory :unknown_content_type_binary do
      extension 'ummm'
      data_url "I'm a number!"
    end
  end
end
