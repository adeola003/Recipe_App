class FoodsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  def index
    @foods = if user_signed_in?
               Food.where(user: current_user)
             else
               []
             end
  end

  def new
    @food = Food.new
  end

  def show
    @food = Food.find_by_id(params[:id])
  end

  def create
    @food = Food.new(foods_data)
    @food.user_id = current_user.id

    if @food.save
      redirect_to foods_path
    else
      render :new, status: 422
    end
  end

  def destroy
    @food = Food.find(params[:id])

    if @food.destroy
      redirect_to foods_path, notice: 'Food has been deleted successfully'
    else
      redirect_to foods_path, alert: 'An error occured while deleting the food'
    end
  end

  private

  def foods_data
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
