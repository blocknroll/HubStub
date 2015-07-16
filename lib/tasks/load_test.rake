require 'capybara/poltergeist'

desc "Simulate load against Hubstub application"
task :load_test => :environment do
  # click_random_article  # single thread
  4.times.map { Thread.new { LoadTest.new.test_site } }.map(&:join)
end

# def click_random_event
#   session = Capybara::Session.new(:poltergeist)
#   loop do
#     session.visit('https://serieux-bastille-5718.herokuapp.com/')
#     session.all('p.feature-event-name a').sample.click
#     puts session.current_path
#   end
# end
