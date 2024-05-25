# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
include Sku

superadmin =
  User.create_with(password: 'password')
      .find_or_create_by(email: 'superadmin@example.com', admin: true)
admin =
  User.create_with(password: 'password')
      .find_or_create_by(email: 'admin@example.com', admin: true)
creator =
  User.create_with(password: 'password')
      .find_or_create_by(email: 'user1@example.com')
member1 =
  User.create_with(password: 'password')
      .find_or_create_by(email: 'user2@example.com')
member2 =
  User.create_with(password: 'password')
      .find_or_create_by(email: 'user3@example.com')
_visitor =
  User.create_with(password: 'password')
      .find_or_create_by(email: 'visitor@example.com', confirmed: false)

# (4..99).to_a.each do |time|
#   User.create_with(password: 'password')
#       .find_or_create_by(email: "user#{time}@example.com",
#                          confirmed: [true, false].sample,
#                          admin: [true, false].sample)
# end

# _post1 = Post.create(title: 'SuperAdmin\'s first post', body: 'This is the first post of the super admin', user: superadmin)
# _post2 = Post.create(title: 'Admin\'s first post', body: 'This is the first post of the admin', user: admin)

# 100.times.each do |time|
#   Post.create(user: [superadmin, admin, creator, member1, member2].sample,
#               title: Faker::Creature::Animal.name,
#               body: generate_sku(excluded: Space.pluck(:description)))
# end

public_space = Space.create(owner: admin, description: 'Public Space', public: true)
space1 = Space.create(owner: creator, description: 'My Shared Space', user_ids: [member1.id])
_space2 = Space.create(owner: creator, description: 'My Private Space', user_ids: [])

# 100.times.each do |time|
#   Space.create(owner: [superadmin, admin, creator, member1, member2].sample,
#                description: generate_sku(excluded: Space.pluck(:description)),
#                user_ids: [[superadmin, admin, creator, member1, member2].sample.id])
# end

Link.create(space: Space.first, owner: creator)

['Japan'].each do |country|
  puts "Country: #{Country.count} - County: #{County.count} - City: #{City.count}";
  puts "Location Seed for #{country} started";
  Locations::Seeds.new(country:).create_all
  puts "Location Seed for #{country} ended";
  puts "Country: #{Country.count} - County: #{County.count} - City: #{City.count}";
end
