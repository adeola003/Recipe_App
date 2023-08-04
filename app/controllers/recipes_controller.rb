# app/controllers/recipes_controller.rb
class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @recipes = Recipe.includes([:user]).where(user: current_user)
  end

  def show
    # @recipe = Recipe.find(params[:id])
    # @foods = Food.joins(:recipe_foods).where(recipe_foods: { recipe_id: @recipe.id })
    @recipe = Recipe.includes(:user, :recipe_foods).find(params[:id])
    @recipe_food = RecipeFood.new

    if @recipe.public? || current_user == @recipe.user
      # Display the recipe details as in the wireframe
    else
      redirect_to recipes_path, alert: 'You are not authorized to view this private recipe.'
    end
    @foods = Food.joins(:recipe_foods).where(recipe_foods: { recipe_id: @recipe.id })

    # Calculate total food items
    @total_food_items = @foods.length

    # Calculate total price
    @total_price = @foods.sum(&:price)
    # fetch list of recipes foods
    @recipe_foods = @recipe.recipe_foods.includes(:food)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: !@recipe.public)
    redirect_to @recipe, notice: 'Public status successfully updated.'
  end

  # def edit
  #   @recipe = Recipe.find(params[:id])
  #   if current_user != @recipe.user
  #     redirect_to recipes_path, alert: "You are not authorized to edit this recipe."
  #   end
  # end

  # def update
  #   @recipe = Recipe.find(params[:id])
  #   if current_user == @recipe.user
  #     if @recipe.update(recipe_params)
  #       redirect_to @recipe, notice: "Recipe was successfully updated."
  #     else
  #       render :edit
  #     end
  #   else
  #     redirect_to recipes_path, alert: "You are not authorized to edit this recipe."
  #   end
  # end
  def public_recipes
    @public = Recipe.includes(:user, :recipe_foods).where(public: true).order('created_at DESC')
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if current_user == @recipe.user
      @recipe.destroy
      redirect_to recipes_path, notice: 'Recipe was successfully deleted.'
    else
      redirect_to recipes_path, alert: 'You are not authorized to delete this recipe.'
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :prep_time, :cooking_time, :public)
  end
end
