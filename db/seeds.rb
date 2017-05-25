
1001.times do |n|
  User.new(name: Faker::LordOfTheRings.character,
          username: "user#{n}",
          email: Faker::Internet.email,
          phone: '5555555555',
          status: 'active',
          token: Faker::Internet.password,
          password: "password",
          avatar_url: Faker::Avatar.image("my-own-slug", "50x50")).save(validate: false)

  user = User.last
  user.owned_folders.new(name: 'home', route: 'home', slug: 'home').save(validate: false)


  folder1 = Folder.create!(name: "Food", parent: user.home, route:"#{user.home.route}/food")
  folder2 = Folder.create!(name: "Pies", parent: folder1, permission: 1 )

  binary2 = Binary.create!(name: "Pizza", folder: user.home, data_url: "https://s3-us-west-1.amazonaws.com/grabbag1701/uploads/27d37700-b571-4872-b056-b77ff1415737/default_profile.jpg", extension: "jpg")
  binary3 = Binary.create!(name: "Stromboli", folder: user.home, data_url: "https://s3-us-west-1.amazonaws.com/grabbag1701/uploads/356361c2-79b0-401e-bad1-f04e5abe34a7/exWweVk.jpg", extension: "png")
  binary1 = Binary.create!(name: "Bratwurst", folder: user.home, data_url: "https://s3-us-west-1.amazonaws.com/grabbag1701/uploads/602c0f1e-4d79-4d13-8676-96f17bffca31/01076249a6024e01b172a6bc20468588.jpeg", extension: "jpg")

  binary4 = Binary.create!(name: "Blackberry Pie ", folder: folder2, data_url: "https://s3-us-west-1.amazonaws.com/grabbag1701/uploads/416c121e-fe11-4cf1-baa8-cabd63ecbeaa/test.jpg", extension: "jpg")

  user.home.folders << folder1
  user.home.binaries << [binary1, binary2, binary3]
  folder1.folders << folder2
  folder2.binaries << binary4

  if n % 10 == 0
    user.folders_shared_with << User.last(3).first.home
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

User.last.update(name: 'Gandalf', role:'admin', username: "admin1")
