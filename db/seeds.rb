require 'database_cleaner'

DatabaseCleaner.clean_with(:truncation)
10.times do |n|
  user = User.create!(name: Faker::LordOfTheRings.character,
              username: "user#{n}",
              email: Faker::Internet.email,
              phone: '5555555555',
              status: 'active',
              password: 'banana',
              avatar_url: 'https://thumb.ibb.co/htakav/default_profile.jpg')
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

  n += 1
end
#test pivotal
