1001.times do |n|
  User.new(name: Faker::LordOfTheRings.character,
          username: "user#{n}",
          email: Faker::Internet.email,
          phone: '5555555555',
          status: 'active',
          token: Faker::Internet.password,
          password: "password",
          avatar_url: 'https://thumb.ibb.co/htakav/default_profile.jpg').save(validate: false)

  user = User.last
  user.owned_folders.new(name: 'home', route: 'home', slug: 'home').save(validate: false)


  folder1 = Folder.create!(name: "Food", parent: user.home, route:"#{user.home.route}/food")
  folder2 = Folder.create!(name: "Pies", parent: folder1 )

  binary2 = Binary.create!(name: "Pizza", folder: user.home, data_url: "https://s3-us-west-1.amazonaws.com/grabbag1701/uploads/pizza.png", extension: ".png")
  binary3 = Binary.create!(name: "Stromboli", folder: user.home, data_url: "https://s3-us-west-1.amazonaws.com/grabbag1701/uploads/stromboli.jpg", extension: ".jpg")
  binary1 = Binary.create!(name: "Bratwurst", folder: user.home, data_url: "https://s3-us-west-1.amazonaws.com/grabbag1701/uploads/recipe_grilled-brat.pdf", extension: ".pdf")

  binary4 = Binary.create!(name: "Blackberry Pie ", folder: folder2, data_url: "https://s3-us-west-1.amazonaws.com/grabbag1701/uploads/blackberry_pie.txt", extension: ".txt")

  user.home.folders << folder1
  user.home.binaries << [binary1, binary2, binary3]
  folder1.folders << folder2
  folder2.binaries << binary4

  n += 1
end

User.last.update(name: 'Gandalf', role:'admin', username: "admin1")
