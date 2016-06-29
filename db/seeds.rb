# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


cam = Campus.new(city: "Durham")
cam.save(:validate => false)

user1 = cam.users.new(name: "Jason Jordan", email: "jj@example.com", password: "hunter2", slack_name: "jason.jordan", klass: "Ruby on Rails")
user1.save(:validate => false)

user2 = cam.users.new(name: "Robyn Pickering", email: "rp@example.com", password: "hunter2", slack_name: "r.pickering", klass: "Front End")
user2.save(:validate => false)
