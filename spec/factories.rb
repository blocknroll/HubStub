FactoryGirl.define do

  sequence :name do |n|
    "category#{n}"
  end

  sequence :title do |n|
    "title#{n}"
  end

  factory :admin do
    full_name "Yolo Ono"
    email "admin@admin.com"
    password "password"
    display_name "Admin"
  end

  factory :user do
    full_name "John Bob Smith"
    email "john@bobo.com"
    password "test"
    password_confirmation "test"
    display_name "John Smithy"
  end

  factory :image do
    title "johnny"
    description "johnny depp"
    img File.new("#{Rails.root}/app/assets/images/heart_pizza.gif")
  end

  factory :item do
    pending false
    unit_price 500
    sold false
    section "1"
    row "1"
    seat "1"
    delivery_method 'email'
    user_id 1
    event_id 1
  end

  factory :category do
    name
  end
end
