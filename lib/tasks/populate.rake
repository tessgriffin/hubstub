require "populator"

desc "Simulate load against HubStub application"
task :populate => :environment do
  @venues = Venue.all
  @categories = Category.all
  @images = Image.all
  Event.populate(30_000) do |event|
    event.title = "Event_#{event.id}"
    event.description = "Description_#{event.id}"
    event.date = 22.days.from_now
    event.start_time = "2000-01-01 22:30:00"
    event.approved = true
    event.image_id = @images.sample.id
    event.venue_id = @venues.sample.id
    event.category_id = @categories.sample.id
  end
  
  @events = Event.all
  
  User.populate(200_000) do |user|
    user.full_name = "Name_#{user.id}"
    user.email = "user_#{user.id}@example.com"
    user.password_digest = "password"
    user.street_1 = "Address1_#{user.id}"
    user.street_2 = "Address2_#{user.id}"
    user.city = "Albuquerque"
    user.state = "NM"
    user.zipcode = 39247
    user.display_name = "User #{user.id}"
    
    
    Item.populate(3) do |item|
      item.unit_price = rand(1000..10000)
      item.pending = false
      item.sold = false
      item.section = rand(1..100)
      item.row = rand(1..50)
      item.seat = rand(1..20)
      item.delivery_method = "physical"
      item.event_id = @events.sample
      item.user_id = user.id
    end
  end
end 
