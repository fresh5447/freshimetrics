require 'faker'

user = User.new(
  email: 'user@user.com',
  password: 'password',
  password_confirmation: 'password')
user.save

  # Create events
  50.times do
    event = Event.create(
      name: Faker::Lorem.word,
      property_1: Faker::Lorem.word,
      property_2: Faker::Lorem.word
    )
    50.times do Parameter.create(
      event: event,
      name: Faker::Lorem.word#,
      # property_1: Faker::Number.number(rand(1..10)),
      # property_2: Faker::Number.number(rand(1..10)),
      )
    end
  end

puts "Seed finished"
puts "#{Event.count} events created"
puts "#{Parameter.count} paramenters created"



