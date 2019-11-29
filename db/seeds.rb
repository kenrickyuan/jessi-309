# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Event.destroy_all
User.destroy_all
User.create!(
  name: "Kristina",
  email: 'kristina_head@icloud.com',
  password: 'testing123'
  )

Event.create!(
  title: "Weekend at Rotterdam",
  location: "Westersingel 1A, 3014 GM, Rotterdam",
  start_time: "2019-10-25 10:19:00 -0200",
  end_time: "2019-10-27 11:19:00 -0200",
  description: "We will be going to a market on Saturday where you have to pay with cash, so don't forget to stop by an ATM beforehand! I'm so excited to see you guys on Friday and make this a weekend to remember!",
  user: User.first
  )

Guest.create!(name: "Kristina", event: Event.find(1))
