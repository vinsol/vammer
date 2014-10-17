namespace :seed do
  desc "TODO"

  task admin: :environment do
    puts 'enter name'
    name = $stdin.gets.chomp
    puts 'enter email_id'
    email_id = $stdin.gets.chomp
    puts 'enter pasword'
    password = $stdin.gets.chomp
    puts 'confirm password'
    confirm_password = $stdin.gets.chomp
    user = User.new(name: name, email: email_id, password: password)
    if password == confirm_password
      user.save
    else
      user.errors.add(:emails, 'Confirm password does not match with password')
    end
    if user.errors
      puts user.errors.full_messages
    end
  end

end
