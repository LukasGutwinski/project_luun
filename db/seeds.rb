# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Request.destroy_all
Listing.destroy_all
User.destroy_all

car1 ={
  brand: "Audi",
  model: "Serie A3",
  origin: "California",
  title: "beautiful Audi A3",
  condition: "New",
  description: "i want to sell this beautiful car",
  mileage: 20000,
  price: 30000,
  year: 2012,
  city: "Phnom Penh",
 }

 car2 ={
  brand: "BMW",
  model: "Serie 3",
  origin: "New York",
  title: "beautiful BMW serie 3",
  condition: "New",
  description: "i want to sell this beautiful car",
  mileage: 20000,
  price: 30000,
  year: 2012,
  city: "Phnom Penh",
 }

user1 = User.new
user1.email = "seller1@luun.com"
user1.password = 'seller1'
user1.listings.build(car1)
user1.listings.build(car2)
user1.save

 car3 ={
  brand: "BMW",
  model: "Serie 5",
  origin: "China",
  title: "beautiful BMW serie 5",
  condition: "New",
  description: "i want to sell this beautiful car",
  mileage: 20000,
  price: 30000,
  year: 2012,
  city: "Phnom Penh",
 }

user2 = User.new
user2.email = "seller2@luun.com"
user2.password = 'seller2'
user2.listings.build(car3)
user2.save

user3 = User.new
user3.email = "buyer1@luun.com"
user3.password = 'buyer1'
user3.save

user4 = User.new
user4.email = "buyer2@luun.com"
user4.password = 'buyer2'
user4.save



