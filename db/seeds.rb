# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |n|
  user = User.create(name: Faker::LordOfTheRings.character,
              username: "user#{n}",
              email: Faker::Internet.email,
              phone: '5555555555',
              status: 'active',
              token: Faker::Internet.password,
              avatar_url: 'https://thumb.ibb.co/htakav/default_profile.jpg')


  data = File.new("factory_date.txt", "w+")
  data.close

  folder1 = Folder.create!(name: "Food", parent: user.home)
  folder2 = Folder.create!(name: "Pies", parent: folder1)

  binary2 = Binary.create!(name: "Pizza", folder: user.home, data: data, content_type: ".txt")
  binary3 = Binary.create!(name: "Stromboli", folder: user.home, data: data, content_type: ".txt")
  binary1 = Binary.create!(name: "Bratwurst", folder: user.home, data: data, content_type: ".txt")

  binary4 = Binary.create!(name: "Blackberry Pie ", folder: folder2, data: data, content_type: ".txt")

  user.home.folders << folder1
  user.home.binaries << [binary1, binary2, binary3]
  folder1.folders << folder2
  folder2.binaries << binary4

  n += 1
end
