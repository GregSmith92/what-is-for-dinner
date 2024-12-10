// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import Choices from "choices.js";

document.addEventListener("turbo:load", () => {
  const ingredientField = document.querySelector("#ingredient-search");
  if (ingredientField) {
    new Choices(ingredientField, {
      removeItemButton: true,
      placeholderValue: "Select ingredients...",
      searchPlaceholderValue: "Search ingredients...",
      searchResultLimit: 10,
    });
  }
});
