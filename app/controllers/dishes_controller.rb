class DishesController < ApplicationController
  def index
    @dishes = Dish.all

    if ingredient_params[:ingredient_ids].present?
      @dishes = @dishes.with_ingredients(ingredient_params[:ingredient_ids])
    end

    if params[:time_available].present?
      @dishes = @dishes.within_time_limit(params[:time_available].to_i)
    end

    @dishes = @dishes.page(params[:page]).per(25)
  end

  private

  def ingredient_params
    params.permit(ingredient_ids: [])
  end
end
