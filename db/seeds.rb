require 'faker'

def random_date
  random = (0..9).to_a
  date = Date.today
  random.sample.times do |_i|
    date += (random.sample.year * -1) + random.sample.month + random.sample.day + random.sample.hour
  end
  date
end

puts "### User Seed started";

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

puts "### User Seed ended";

# (4..99).to_a.each do |time|
#   User.create_with(password: 'password')
#       .find_or_create_by(email: "user#{time}@example.com",
#                          confirmed: [true, false].sample,
#                          admin: [true, false].sample)
# end

# _post1 = Post.create(title: 'SuperAdmin\'s first post', body: 'This is the first post of the super admin', user: superadmin)
# _post2 = Post.create(title: 'Admin\'s first post', body: 'This is the first post of the admin', user: admin)

# include Sku
# 100.times.each do |time|
#   Post.create(user: [superadmin, admin, creator, member1, member2].sample,
#               title: Faker::Creature::Animal.name,
#               body: generate_sku(excluded: Space.pluck(:description)))
# end


puts "### Space Seed started";

public_space = Space.create(owner: admin, description: 'Public Space', public: true)
space1 = Space.create(owner: creator, description: 'My Space', user_ids: [member1.id])
_space2 = Space.create(owner: creator, description: 'My Space', user_ids: [])

# 100.times.each do |time|
#   Space.create(owner: [superadmin, admin, creator, member1, member2].sample,
#                description: generate_sku(excluded: Space.pluck(:description)),
#                user_ids: [[superadmin, admin, creator, member1, member2].sample.id])
# end

Link.create(space: Space.first, owner: creator)

puts "### Space Seed ended";

puts "### Location Seed started";
['Japan'].each do |country|
  initial_country_count = Country.count
  initial_county_count = County.count
  initial_city_count = City.count
  puts "Initial location count for Country: #{initial_country_count} - " \
       "County: #{initial_county_count} - " \
       "City: #{initial_city_count}";
  puts "# Location Seed for #{country} started";
  Locations::Seeds.new(country:).create_all
  puts "# Location Seed for #{country} ended";
  puts "Created count location for Country: #{Country.count - initial_country_count} - " \
       "County: #{County.count - initial_county_count} - " \
       "City: #{City.count - initial_city_count}";
end

puts "### Location Seed ended";


puts "### Post Seed started";

initial_post_count = Post.count

puts "Initial post count: #{initial_post_count}"

(1..100).to_a.each do |sn|
  Post.create(
    title: "Creator post #{sn}",
    creator: creator,
    location: Location.all.sample,
    content: Faker::Quote.matz,
    starts_at: [random_date, nil].sample,
    ends_at: [random_date, nil].sample,
    frequency: [Post::FREQUENCIES.sample, nil].sample,
    space_ids: Space.ids
  )
end

(1..50).to_a.each do |sn|
  Post.create(
    title: "Member1 post #{sn}",
    creator: member1,
    location: Location.all.sample,
    content: Faker::Quote.matz,
    url: Faker::Internet.domain_name,
    starts_at: [random_date, nil].sample,
    ends_at: [random_date, nil].sample,
    frequency: [Post::FREQUENCIES.sample, nil].sample,
    space_ids: [space1.id]
  )
end

puts "Created post count: #{Post.count - initial_post_count}"

puts "### Post Seed ended";
