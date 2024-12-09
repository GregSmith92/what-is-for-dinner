# local file example: file_path = Rails.root.join("storage/json_files/recipes-en.json")
class RecipesImporter
  def initialize(file_path)
    @file_path = file_path
  end

  def import
    Rails.logger.tagged(logging_tag).info("Starting Recipe Import")
    File.open(@file_path) do |file|
      JSON.parse(file.read).each do |record_data|
      begin
        create_recipes(record_data)
      rescue StandardError => e
        Rails.logger.tagged(logging_tag).error("Error creating dish with title: #{title}. Error: #{e}")
      end
    end
  end

  private

  def create_recipe(recipe_data)
    # Find or create Dish
    dish = Dish.find_or_create_by!(title: recipe_data["title"], author: recipe_data["author"]) do |d|
      d.cook_time = recipe_data["cook_time"]
      d.prep_time = recipe_data["prep_time"]
      d.ratings = recipe_data["ratings"]
      d.cuisine = recipe_data["cuisine"]
      d.category = recipe_data["category"]
      d.image_url = recipe_data["image"]
    end

    # Add ingredients to the dish
    recipe_data["ingredients"].each do |ingredient_entry|
      # Extract ingredient name and quantity
      quantity, name = IngredientParser.parse(ingredient_entry)

      ingredient = Ingredient.find_or_create_by!(name: name)
      DishIngredient.create!(
        dish: dish,
        ingredient: ingredient,
        quantity: quantity
      )
    end
  end
end
