require 'capybara/poltergeist'

desc "Simulate load against HubStub application"
task :load_test => :environment do
  4.times.map { Thread.new { browse } }.map(&:join)
end

def browse
  session = Capybara::Session.new(:poltergeist)
  loop do
    session.visit("http://localhost:3000/")
    puts "visited home page"
  end
end