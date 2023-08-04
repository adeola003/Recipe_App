FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    email { 'john@example.com' }
    password { 'password' }
  end
  factory :food do
    name { "Example Food" }
    measurement_unit { "pieces" }
    price { 5 }
    quantity { 10 }
  end

end
