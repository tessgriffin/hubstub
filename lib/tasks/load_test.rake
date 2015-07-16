require 'capybara/poltergeist'

desc "Simulate load against HubStub application"
task :load_test => :environment do
  4.times.map { Thread.new { browse } }.map(&:join)
end
  
def browse
  session = Capybara::Session.new(:poltergeist)
  loop do  
    session.visit("http://boiling-woodland-9495.herokuapp.com/")
    session.click_link("Adventure")
  end
end