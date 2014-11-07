# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

puts 'enter name'
name = STDIN.gets.chomp

puts 'enter email_id'
email_id = STDIN.gets.chomp

puts 'enter pasword'
password = STDIN.gets.chomp

puts 'confirm password'
confirm_password = STDIN.gets.chomp

user = User.new(name: name, email: email_id, password: password, password_confirmation: confirm_password, admin: true, enabled: true)
if user.save
  puts "Admin with email id #{user.email} is created"
else
  puts user.errors.full_messages
end

setting = Setting.create
setting.build_image
puts 'setting for logo is saved'
