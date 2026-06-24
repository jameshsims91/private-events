Invitation.destroy_all
EventAttendance.destroy_all
Event.destroy_all
User.destroy_all

puts "Seeding data..."

host = User.create!(
  name: "Host Jay"
  email: "jaythenovice@gmail.com"
  password: "Blakowl123"
  password_confirmation: "Blakowl123"
)

guest = User.create!(
  name: "Guest Bob",
  email: "bob@example.com"
  password: "password123"
  password_confirmation: "password123"
)

event = host.created_events.create!(
  title: "Secret Strategy Meeting"
  date: Date.today + 5.days,
  description: "Planning our master plan. Invite only!",
  private: true
)

event.invited_users << guest

puts "Seeding complete!
puts "Logged in as Host: jaythenovice@gmail.com / Blakowl123"
puts "Logged in as Guest: bob@example.com / password123"
