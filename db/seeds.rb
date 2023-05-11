require 'faker'

# création de 10 villes
10.times do
  City.create(
    name: Faker::Address.city,
    zip_code: Faker::Address.zip_code
  )
end

# création de 10 utilisateurs et assignation aléatoire à une ville
10.times do
  user = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    date_of_birth: Faker::Date.between(from: 80.years.ago, to: 18.years.ago),
    gender: ['M', 'F'].sample
  )
  user.city = City.all.sample
  user.save
end


# création de 10 tags
10.times do
  Tag.create(
    title: Faker::Game.genre
  )
end

40.times do
  Gossip.create(
    title: Faker::Book.title,
    content: Faker::Lorem.paragraph(sentence_count: 5),
    user: User.find(rand(1..10))
  )
end

# création de quelques messages privés
3.times do
  sender = User.all.sample
  recipient = User.all.sample
  while recipient == sender
    recipient = User.all.sample
  end
  PrivateMessage.create(
    content: Faker::Lorem.paragraph(sentence_count: 2),
    sender: sender,
    recipient: recipient
  )
end

# création de 20 commentaires et assignation aléatoire à un utilisateur et à un gossip
300.times do
  Comment.create(
    content: Faker::Lorem.paragraph(sentence_count: 2),
    user: User.find(rand(1..10)),
    gossip: Gossip.find(rand(1..30))
  )
end

# création de 20 likes aléatoires
20.times do
  like = Like.create
  like.user = User.all.sample
  like.likeable = [Gossip.all, Comment.all].sample.sample
  like.save
end
