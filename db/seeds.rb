# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

BrandModel.destroy_all
Brand.destroy_all

a = Brand.create(name: 'Audi')
b = Brand.create(name: 'BMW')
c = Brand.create(name: 'Mercedes')

a.brand_models.build(name: 'A1').save
a.brand_models.build(name: 'A3').save
a.brand_models.build(name: 'TT').save

b.brand_models.build(name: 'Serie 1').save
b.brand_models.build(name: 'Serie 3').save
b.brand_models.build(name: 'Serie 5').save

c.brand_models.build(name: 'Class A').save
c.brand_models.build(name: 'Class C').save
c.brand_models.build(name: 'Class E').save
