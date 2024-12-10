# Imports recipes from a JSON file, splitting into Dishes and Ingredients
class RecipesImporter
  def initialize(file_path: Rails.root.join("storage/json_files/recipes-en.json"))
    @file_path = file_path
  end

  def import
    Rails.logger.info("Starting Recipe Import")
    File.open(@file_path) do |file|
      JSON.parse(file.read).each do |record_data|
        begin
          create_recipes(record_data)
        rescue StandardError => e
          Rails.logger.error("Error creating dish with title: #{record_data["title"]}. Error: #{e}")
        end
      end
    end
    true
  end

  private

  def create_recipes(recipe_data)
    # Find or create Dish
    dish = Dish.find_or_create_by!(title: recipe_data["title"], author: recipe_data["author"]) do |d|
      d.cook_time = recipe_data["cook_time"]
      d.prep_time = recipe_data["prep_time"]
      d.ratings = recipe_data["ratings"]
      d.category = recipe_data["category"]
      d.image_url = decode_image(recipe_data["image"])
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

  def decode_image(image)
    return unless image.present? 

    uri = URI.parse(image)
    return unless uri.query
  
    params = URI.decode_www_form(uri.query).to_h
    params['url']
  end
end
