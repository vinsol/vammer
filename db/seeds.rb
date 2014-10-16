# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# fix- Move inside /db -DONE
# fix- Add description -DONE
puts 'enter name'
# fix- Check if there are any other ways to take input from user -DONE
name = STDIN.gets.chomp

puts 'enter email_id'
email_id = STDIN.gets.chomp

puts 'enter pasword'
password = STDIN.gets.chomp

puts 'confirm password'
confirm_password = STDIN.gets.chomp

# fix- Below statement will create normal user. we need Admin. -DONE
user = User.new(name: name, email: email_id, password: password, password_confirmation: confirm_password, admin: true)
if user.save
  puts 'user is saved'
else
  puts user.errors.full_messages
end
# fix- Check is devise does this itself -DONE
# fix- No need to add custom message -DONE
# fix- Use "if user.save" below and show a message for success also -DONE
