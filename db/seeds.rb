# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Cat.destroy_all
CatRentalRequest.destroy_all

ApplicationRecord.connection.reset_pk_sequence!('cats')
ApplicationRecord.connection.reset_pk_sequence!('cat_rental_requests')

ActiveRecord::Base.transaction do
  c1 = Cat.create!(name: "jay", birth_date: Time.now, color: "black", sex: "M", description: "emperor")
  c2 = Cat.create!(name: "cam", birth_date: 2.days.ago, color: "white", sex: "F", description: "ice queen")
  c3 = Cat.create!(name: "mom", birth_date: 3.days.ago, color: "grey", sex: "F", description: "mother")

  r1 = CatRentalRequest.create!(cat_id: 1, start_date: Date.new(2019, 01, 01), end_date: Date.new(2019, 01, 07))
  r2 = CatRentalRequest.create!(cat_id: 2, start_date: Date.new(2019, 01, 01), end_date: Date.new(2019, 01, 07))
  r3 = CatRentalRequest.create!(cat_id: 1, start_date: Date.new(2019, 01, 07), end_date: Date.new(2019, 01, 8))
  r4 = CatRentalRequest.create!(cat_id: 1, start_date: Date.new(2019, 01, 02), end_date: Date.new(2019, 01, 05))
  r5 = CatRentalRequest.create!(cat_id: 1, start_date: Date.new(2019, 01, 01), end_date: Date.new(2019, 01, 02))
  r6 = CatRentalRequest.create!(cat_id: 1, start_date: Date.new(2019, 01, 01), end_date: Date.new(2019, 01, 02), status: 'APPROVED')

end

