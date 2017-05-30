require 'database_cleaner'

DatabaseCleaner.clean_with(:truncation)
101.times do |n|
  user = User.create!(name: Faker::LordOfTheRings.character,
              username: "user#{n}",
              email: Faker::Internet.email,
              phone: '5555555555',
              status: 'active',
              password: 'banana',
              avatar_url: Faker::Avatar.image("#{Faker::Internet.email}", "50x50"))
  puts "User #{user.username} created"


  folder1 = Folder.create!(name: "Food", parent: user.home)
  folder2 = Folder.create!(name: "Pies", parent: folder1)
  puts "Folder #{folder2.name} created within #{folder1.name}!"

  binary2 = Binary.create!(name: "Pizza", folder: user.home, data_url: "https://s3-us-west-1.amazonaws.com/grabbag1701/uploads/pizza.png", extension: ".png")
  binary3 = Binary.create!(name: "Stromboli", folder: user.home, data_url: "https://s3-us-west-1.amazonaws.com/grabbag1701/uploads/stromboli.jpg", extension: ".jpg")
  binary1 = Binary.create!(name: "Bratwurst", folder: user.home, data_url: "https://s3-us-west-1.amazonaws.com/grabbag1701/uploads/recipe_grilled-brat.pdf", extension: ".pdf")
  puts "Binary #{binary1.name}, #{binary2.name}, and #{binary3.name}, created in home folder."
  binary4 = Binary.create!(name: "Blackberry Pie ", folder: folder2, data_url: "https://s3-us-west-1.amazonaws.com/grabbag1701/uploads/blackberry_pie.txt", extension: ".txt")
  puts "Binary #{binary4.name}, created in #{folder2.name} folder."

  if n % 10 == 0
    user.folders_shared_with << User.last(3).first.home
    folder3 = Folder.create!(name: "Pub Folder#{n}", parent: user.home, permission: 'root_global')
  end

  comment1 = binary1.comments.create(text: "This is a commment #1", user_id: user.id)
  comment2 = binary1.comments.create(text: "This is a commment #2", user_id: user.id)
  comment3 = binary2.comments.create(text: "This is a commment #3", user_id: user.id)
  comment4 = binary2.comments.create(text: "This is a commment #4", user_id: user.id)
  comment5 = binary3.comments.create(text: "This is a commment #5", user_id: user.id)
  comment6 = binary3.comments.create(text: "This is a commment #6", user_id: user.id)
  comment7 = binary4.comments.create(text: "This is a commment #7", user_id: user.id)
  comment8 = binary4.comments.create(text: "This is a commment #8", user_id: user.id)

  comment1.likes.create(user_id: user.id, likeable_type: "Comment", likeable_id: 1)
  comment1.likes.create(user_id: user.id, likeable_type: "Comment", likeable_id: 1)
  comment2.likes.create(user_id: user.id, likeable_type: "Comment", likeable_id: 1)
  comment2.likes.create(user_id: user.id, likeable_type: "Comment", likeable_id: 1)
  comment3.likes.create(user_id: user.id, likeable_type: "Comment", likeable_id: 1)
  comment3.likes.create(user_id: user.id, likeable_type: "Comment", likeable_id: 1)
  comment4.likes.create(user_id: user.id, likeable_type: "Comment", likeable_id: 1)
  comment4.likes.create(user_id: user.id, likeable_type: "Comment", likeable_id: 1)
  comment5.likes.create(user_id: user.id, likeable_type: "Comment", likeable_id: 1)
  comment6.likes.create(user_id: user.id, likeable_type: "Comment", likeable_id: 1)
  comment7.likes.create(user_id: user.id, likeable_type: "Comment", likeable_id: 1)
  comment8.likes.create(user_id: user.id, likeable_type: "Comment", likeable_id: 1)

  binary1.likes.create(user_id: user.id, likeable_type: "Binary", likeable_id: 1)
  binary2.likes.create(user_id: user.id, likeable_type: "Binary", likeable_id: 1)
  binary3.likes.create(user_id: user.id, likeable_type: "Binary", likeable_id: 1)
  binary4.likes.create(user_id: user.id, likeable_type: "Binary", likeable_id: 1)

  n += 1
  puts "Created #{user.name}"
end

User.last.update(name: 'Gandalf', role:'admin', username: "admin1", avatar_url: "https://thumb.ibb.co/htakav/default_profile.jpg")
