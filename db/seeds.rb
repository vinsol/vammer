# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

puts 'enter name'
name = STDIN.gets.chomp

#FIXME_AB: You should tell that this email id should be the company id. Read domain from config.yml
#FIXME_AB: Also make sure that your rails application doesn't boot if it doesn't have config.yml file with company name and domain.
puts "enter email_id with domain name as #{COMPANY['domain']}"
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
#FIXME_AB: Where is logo saved, where did we assigned? You just created setting and build image