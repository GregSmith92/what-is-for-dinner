class Dish < ApplicationRecord
  has_many :dish_ingredients
  has_many :ingredients, through: :dish_ingredients

  scope :with_ingredients, ->(ingredient_ids) {
    joins(:ingredients)
      .where(ingredients: { id: ingredient_ids })
      .select("dishes.*, COUNT(ingredients.id) AS matching_ingredients_count")
      .group("dishes.id")
      .order("matching_ingredients_count DESC")
  }

  # Scope to filter dishes by available time
  scope :within_time_limit, ->(time_available) {
    where("prep_time + cook_time <= ?", time_available)
  }
end
