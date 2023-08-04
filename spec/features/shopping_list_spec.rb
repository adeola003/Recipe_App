require 'rails_helper'

RSpec.feature 'Shopping List', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:food) { FactoryBot.create(:food, user: user, quantity: 5) }

  before do
    # Sign in the user using Devise test helper
    sign_in user
  end

  scenario 'User visits the shopping list page' do
    # Create an example recipe item in the database associated with the user
    recipe = Recipe.create(name: 'Recipe 1', description: 'Recipe Description', prep_time: 30, cooking_time: 60, user: user)

    # Create an example recipe food item in the database associated with the recipe and food
    recipe_food = RecipeFood.create(recipe: recipe, food: food, quantity: 10)

    # Visit the shopping list page
    visit shopping_list_path
    save_and_open_page

    # Assert that the page displays the shopping list details
    expect(page).to have_content("Shopping List for #{user.name}")
    expect(page).to have_content('Amount of food items to buy: 1')
    expect(page).to have_content('Total value of food needed: $25') # Assuming food price is $5 and quantity difference is 5 (10 - 5)
    expect(page).to have_content("#{food.name} (5)")
    expect(page).to have_content("10 #{food.measurement_unit}")
    expect(page).to have_content("$#{food.price}")
    expect(page).to have_content("$25") # Assuming food price is $5 and quantity difference is 5 (10 - 5)
  end
end
