# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

state_list = [ "New South Wales", "Victoria", "South Australia", "ACT", "Queensland", "Northern Territory", "Western Australia", "Tasmania" ]
city_list = [ "Sydney", "Brisbane", "Melbourne", "Canberra", "Darwin", "Wollongong", "Perth", "Adelaide", "Hobart" ]
postcode_list = [ "2233", "2232", "2231", "2230" ]
size_list = [ 6, 8, 10, 12, 14, 16, 18, 20 ]
brand_list = [ "Zimmerman", "Nookie", "Bec + Bridge", "Jadore", "Alice McCall", "other" ]
style_list = [ "Mini", "Midi", "Full length", "Formal", "Jumpsuit", "other"]

state_list.each do |state|
  State.create( title: state)
end

city_list.each do |city|
  City.create( title: city)
end

postcode_list.each do |postcode|
  Postcode.create( title: postcode)
end

size_list.each do |size|
  Size.create( title: size)
end

brand_list.each do |brand|
  Brand.create( title: brand)
end

style_list.each do |style|
  Style.create( title: style)
end