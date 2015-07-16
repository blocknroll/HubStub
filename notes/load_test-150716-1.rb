require 'capybara/poltergeist'

class LoadTest

  attr_reader :session

  def initialize
    @session = Capybara::Session.new(:poltergeist)
  end

  def test_site
    loop do
      visit_root
      begin
        browse_events
        click_adventure
      end
    end
  end


      private

        def visit_root
          session.visit("https://serieux-bastille-5718.herokuapp.com/")
          puts "visited root"
        end

        def browse_events
          50000.times do |e|
            puts "visited event #{e}"
            begin
              session.visit("https://serieux-bastille-5718.herokuapp.com/#{e}")
            end
          end
        end

        def click_adventure
          visit_root
          session.click_link("Adventure")
          puts "visited Adventure"
        end



end
