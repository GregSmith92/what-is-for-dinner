namespace :recipes do
  task seed_data: :environment do
    RecipesImporter.new(Rails.root.join("config/data/recipes-en.json")).import
  end
end
