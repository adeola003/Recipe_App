require 'rails_helper'

RSpec.feature 'Food', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    # Sign in the user using Devise test helper
    sign_in user

    # Create some example food items associated with the user
    user.foods.create(name: 'Apple', measurement_unit: 'pieces', price: 1.5, quantity: 10)
    user.foods.create(name: 'Banana', measurement_unit: 'pieces', price: 0.75, quantity: 5)
  end

  scenario 'User visits the food index page' do
    # Visit the food index page
    visit foods_path
    # Assert that the page displays the food items
    expect(page).to have_content('Food List')
    expect(page).to have_content('Apple')
    expect(page).to have_content('Banana')
    expect(page).to have_content('$1')
    expect(page).to have_content('$0')
  end

  scenario 'User visits the food show page' do
    # Find the first food item associated with the user
    food = user.foods.first

    # Visit the food show page
    visit food_path(food)

    # Assert that the page displays the food details
    expect(page).to have_content(food.name)
    expect(page).to have_content("Measurement: 0")
    expect(page).to have_content("Price in $: 1")
    expect(page).to have_content("Quantity: 10")
  end
end
