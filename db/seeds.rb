Invitation.destroy_all
EventAttendance.destroy_all
Event.destroy_all
User.destroy_all

puts "Seeding data..."

# 1. Create the Host (FIXED: Added commas at the end of lines 9, 10, and 11)
host = User.create!(
  name: "Host Jay",
  email: "jaythenovice@gmail.com",
  password: "Blakowl123",
  password_confirmation: "Blakowl123"
)

# 2. Create the Guest (FIXED: Added commas at the end of lines 17 and 18)
guest = User.create!(
  name: "Guest Bob",
  email: "bob@example.com",
  password: "password123",
  password_confirmation: "password123"
)

# 3. Create the Event (FIXED: Added a comma at the end of line 23)
event = host.created_events.create!(
  title: "Secret Strategy Meeting",
  date: Date.today + 5.days,
  description: "Planning our master plan. Invite only!",
  private: true
)

# 4. Associate the invitation relationship
event.invited_users << guest

# FIXED: Added the missing closing quotation mark at the end of "Seeding complete!"
puts "Seeding complete!"
puts "Logged in as Host: jaythenovice@gmail.com / Blakowl123"
puts "Logged in as Guest: bob@example.com / password123"
