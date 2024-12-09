namespace :recipes do
  task seed_data: :environment do
    RecipesImporter.new(Rails.root.join("storage/json_files/recipes-en.json")).import
  end
end
