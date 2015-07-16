require 'capybara/poltergeist'

class LoadTest
  attr_reader :session


  def initialize
    @session = Capybara::Session.new(:poltergeist)
  end

  def test_site
    loop do
      visit_root
      click_random_event
      browse_events
      # begin
      # [create_ticket,
      #   past_orders,
      #   edit_profile,
      #   search_events,
      #   add_to_cart_create_account,
      #   admin_edit_event,
      #   admin_venue,
      #   admin_create_event,
      #   admin_category_crud,
      #   admin_venue_crud,
      #   log_out].sample
      #
      # rescue *ERRORS => error
      #   puts error
      #   log_out if session.has_css?(".logout")
      # end
    end
  end


  def click_random_event
    session.visit('https://serieux-bastille-5718.herokuapp.com/')
    session.all('p.feature-event-name a').sample.click
    puts "visted random event on home page: #{session.current_path}"
  end


  def browse_events
    10.times do |i|
      begin
        session.visit("https://serieux-bastille-5718.herokuapp.com/events/#{i}")
        puts "browsed event #{i}"
      rescue *ERRORS => error
        puts error
        log_out if session.has_css?(".logout")
      end
    end
  end

  private

  def past_orders
    puts "Orders"
    log_in("tyler@mayhem.com", "password")
    session.click_link("My Hubstub")
    session.click_link("Past Orders")
    session.click_link("My Hubstub")
    session.click_link("My Listings")
    log_out
  end

  def edit_profile
    puts "profile edited"
    log_in("tyler@mayhem.com", "password")
    session.click_link("My Hubstub")
    session.click_link("Manage Account")
    session.click_link("Edit User Profile")
    session.fill_in "user[city]", with: "Denver"
    session.click_button("Update Account")
    log_out
  end

  def create_ticket
    puts "created ticket"
    log_in("tyler@mayhem.com", "password")
    session.click_link("My Hubstub")
    session.click_link("List a Ticket")
    session.select "sunt", from: "item[event_id]"
    session.fill_in "item[section]", with: "TT"
    session.fill_in "item[row]", with: "666"
    session.fill_in "item[seat]", with: "10"
    session.fill_in "item[unit_price]", with: 33
    session.select  "Electronic", from: "item[delivery_method]"
    session.click_button("List Ticket")
    log_out
  end

  def search_events
    puts "events filter used"
    session.click_link("Buy")
    session.click_link("All Tickets")
    session.click_link("Sports")
    session.click_link("Music")
    session.click_link("Theater")
  end

  def add_to_cart_create_account
    puts "cart"
    session.click_link("Buy")
    session.click_link("All Tickets")
    session.all("p.event-name a").sample.click
    session.all(:css, "input.btn").sample.click
    session.click_link("Cart(1)")
    session.click_link("Checkout")
    session.click_link("here")


    puts "add item to cart, create account, and remove cart item"
    session.fill_in "user[full_name]", with: "Norm User"
    session.fill_in "user[display_name]", with: ("A".."Z").to_a.shuffle.first(2).join
    session.fill_in "user[email]", with: (1..20).to_a.shuffle.join + "@example.com"
    session.fill_in "user[street_1]", with: "main st"
    session.fill_in "user[city]", with: "Denver"
    session.select  "Colorado", from: "user[state]"
    session.fill_in "user[zipcode]", with: "80204"
    session.fill_in "user[password]", with: "password"
    session.fill_in "user[password_confirmation]", with: "password"
    session.click_button("Create my account!")

    session.click_link("Cart(1)")
    session.click_link_or_button("Remove")
  end

  def admin_edit_event
    puts "admin event edit"
    log_in("admin@admin.com", "password")
    session.click_link "Users"
    session.all("tr").sample.click_link "Store"
    session.click_link "Events"
    session.click_link "Manage Events"
    session.click_link("Edit", :match => :first)
    session.fill_in "event[title]", with: ("A".."Z").to_a.shuffle.first(5).join
    session.fill_in "event[date]", with: 33.days.from_now.change({ hour: 5, min: 0, sec: 0  })
    session.fill_in "event[start_time]", with: "2000-01-01 19:00:00"
    session.click_button "Submit"
    log_out
  end

  def admin_venue
    puts "admin venue crud"
    log_in("admin@admin.com", "password")
    session.click_link "Events"
    session.click_link "Manage Venues"
    session.all("tr").last.click_link "Edit"
    session.fill_in "venue[location]", with: "Charleston"
    session.click_button("Submit")
    log_out
  end

  def admin_create_event
    puts "admin create event"
    log_in("admin@admin.com", "password")
    session.click_link "Manage Events"
    session.click_link "Create Event"
    session.fill_in "event[title]", with: "Sample Ticket"
    session.fill_in "event[description]", with: "No description necessary."
    session.fill_in "event[date]", with: 33.days.from_now.change({ hour: 5, min: 0, sec: 0  })
    session.fill_in "event[start_time]", with: "2000-01-01 19:00:00"
    session.click_button "Submit"
    log_out
  end

  def admin_venue_crud
    puts "venue crud"
    log_in("admin@admin.com", "password")
    session.click_link_or_button("Create Venue")
    session.fill_in "venue[name]", with: "fake venue"
    session.fill_in "venue[location]", with: "no where"
    session.click_button("Submit")
    session.all("tr").last.click_link "Delete"
    log_out
  end

  def admin_category_crud
    puts "admin category crud"
    log_in("admin@admin.com", "password")
    session.click_link "Events"
    session.click_link "Manage Categories"
    session.click_link_or_button("Create Category")
    session.fill_in "category[name]", with: "fake category"
    session.click_button("Submit")

    session.all("tr").last.click_link "Edit"
    session.fill_in "category[name]", with: "still fake"
    session.click_button("Submit")

    session.all("tr").last.click_link "Delete"
    log_out
  end

  def log_out
    session.click_link("Logout")
  end

  def visit_root
    session.visit("https://serieux-bastille-5718.herokuapp.com/")
    puts "visited root page"
  end

  def log_in(email, password)
    session.click_link("Login")
    session.fill_in "session[email]", with: email
    session.fill_in "session[password]", with: password
    session.click_link_or_button("Log in")
  end


    ERRORS = [
    Capybara::Poltergeist::TimeoutError,
    NameError,
    EOFError,
    NoMethodError,
    Errno::EAGAIN,
    Errno::ECONNRESET,
    Errno::EINVAL,
    Errno::EBADF,
    Net::HTTPBadResponse,
    Net::HTTPHeaderSyntaxError,
    Net::ProtocolError,
    Timeout::Error,
    Capybara::ElementNotFound
  ]
end
