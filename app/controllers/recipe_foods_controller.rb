class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_recipe, only: %i[show toggle_public]

  def show
    @recipe_food = RecipeFood.new # Initialize a new RecipeFood instance for the form
    # Rest of the code
  end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new(recipe_id: params[:recipe_id])
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)

    # Set the recipe ID to associate the food item with the current recipe
    @recipe_food.recipe = Recipe.find(params[:recipe_id])

    if @recipe_food.save
      redirect_to @recipe_food.recipe, notice: 'Food item was successfully added to the recipe.'
    else
      # Handle validation errors if any
      @recipe = @recipe_food.recipe
      render 'recipes/show'
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
