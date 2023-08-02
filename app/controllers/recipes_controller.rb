# app/controllers/recipes_controller.rb
class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      redirect_to @recipe, notice: "Recipe was successfully created."
    else
      render :new
    end
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

  def destroy
    @recipe = Recipe.find(params[:id])
    if current_user == @recipe.user
      @recipe.destroy
      redirect_to recipes_path, notice: "Recipe was successfully deleted."
    else
      redirect_to recipes_path, alert: "You are not authorized to delete this recipe."
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :prep_time, :cooking_time, :public)
  end
end

