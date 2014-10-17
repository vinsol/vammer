# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'enter name'
name = STDIN.gets.chomp

puts 'enter email_id'
email_id = STDIN.gets.chomp

puts 'enter pasword'
password = STDIN.gets.chomp

puts 'confirm password'
confirm_password = STDIN.gets.chomp

# fix- #admin should not be mass-assignable. Assign it after initializing object -DONE
user = User.new(name: name, email: email_id, password: password, password_confirmation: confirm_password, admin: true)
if user.save
  # fix- Add email to the message. Make it more descriptive. -DONE
  puts "Admin with email id #{user.email} is saved"
else
  puts user.errors.full_messages
end
