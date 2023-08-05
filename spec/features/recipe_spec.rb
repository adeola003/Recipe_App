require 'rails_helper'

RSpec.feature 'Recipe', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    # Sign in the user using Devise test helper
    sign_in user
  end

  scenario 'User visits the recipe index page' do
    # Create some example recipes in the database associated with the user
    Recipe.create(name: 'Apple Pie', description: 'Delicious Apple Pie', prep_time: 20, cooking_time: 40,
                  user:)
    Recipe.create(name: 'Pasta', description: 'Tasty Pasta', prep_time: 15, cooking_time: 30, user:)

    # Visit the recipe index page
    visit recipes_path

    # Assert that the page displays the recipe items
    expect(page).to have_content('Recipes list')
    expect(page).to have_content('Apple Pie')
    expect(page).to have_content('Pasta')
    expect(page).to have_content('Delicious Apple Pie')
    expect(page).to have_content('Tasty Pasta')
  end

  scenario 'User visits the recipe show page' do
    # Create an example recipe item in the database associated with the user
    recipe = Recipe.create(name: 'Apple Pie', description: 'Delicious Apple Pie', prep_time: 20, cooking_time: 40,
                           user:)

    # Visit the recipe show page
    visit recipe_path(recipe)

    # Assert that the page displays the recipe details
    expect(page).to have_content('Apple Pie')
    expect(page).to have_content('Description: Delicious Apple Pie')
    expect(page).to have_content('Prep Time: 20 minutes')
    expect(page).to have_content('Cooking Time: 40 minutes')
    expect(page).to have_content('Public: Yes')
  end

  scenario 'User visits the public recipes page' do
    # Create some example recipes in the database with public set to true
    Recipe.create(name: 'Public Recipe 1', description: 'Public Recipe Description 1', prep_time: 30,
                  cooking_time: 60, user:, public: true)
    Recipe.create(name: 'Public Recipe 2', description: 'Public Recipe Description 2', prep_time: 25,
                  cooking_time: 50, user:, public: true)

    # Visit the public recipes page
    visit public_recipes_path

    # Assert that the page displays the public recipe items
    expect(page).to have_content('Public Recipes')
    expect(page).to have_content('Public Recipe 1')
    expect(page).to have_content('Public Recipe 2')
    expect(page).to have_content('by: John Doe')
  end
end
