puts "Generating Admin"
Admin.find_or_create_by!(email: 'admin@admin.com', password: '123456')
puts "Admin Generated"

puts "Generating User"
User.find_or_create_by!(email: 'user@user.com', password: '123546')
puts "User Generated"
