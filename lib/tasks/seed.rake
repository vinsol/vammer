# fix- Move inside /db
namespace :seed do
  # fix- Add description
  desc "TODO"

  task admin: :environment do
    puts 'enter name'
    # fix- Check if there are any other ways to take input from user
    name = $stdin.gets.chomp

    puts 'enter email_id'
    email_id = $stdin.gets.chomp

    puts 'enter pasword'
    password = $stdin.gets.chomp

    puts 'confirm password'
    confirm_password = $stdin.gets.chomp

    # fix- Below statement will create normal user. we need Admin.
    user = User.new(name: name, email: email_id, password: password)
    # fix- Check is devise does this itself
    if password == confirm_password
      user.save
    else
      # fix- No need to add custom message
      user.errors.add(:emails, 'Confirm password does not match with password')
    end
    # fix- Use "if user.save" below and show a message for success also
    if user.errors
      puts user.errors.full_messages
    end
  end

end
