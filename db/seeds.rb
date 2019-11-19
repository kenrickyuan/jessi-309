# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Event.destroy_all
User.create!(
  email: 'mark_ruffalo@icloud.com',
  password: 'testing123'
  )

Event.create!(
  title: "Our First Product Pitch",
  location: "Amsterdam",
  start_time: "2015-12-08 10:19:00 -0200",
  end_time: "2015-12-08 10:19:00 -0200",
  guests: 13
  )
