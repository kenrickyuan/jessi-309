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
  name: "Mark",
  email: 'mark_ruffalo@icloud.com',
  password: 'testing123'
  )

Event.create!(
  title: "Our First Product Pitch",
  location: "Amsterdam",
  start_time: "2019-12-08 10:19:00 -0200",
  end_time: "2019-12-08 11:19:00 -0200",
  description: "Bring your pampers!",
  user: User.first
  )
