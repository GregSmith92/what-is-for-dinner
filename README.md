# README

## About
Hosted on Hetzner VPS, deployed with Kamal, SQlite database, Rails 8

## User Stories

### 1. I want to search for recipes based on the ingredients I have at home, so I can find meals that have the best match for ingredients I have at home

- Users can input a list of ingredients they currently have.
- The application filters and displays recipes that match the entered ingredients.
- Recipes with the most matching ingredients are prioritized in the results.

### 2. I want to set a maximum cooking time, so I can find recipes that fit into my available schedule.

- Users can specify the maximum time (in minutes) they have available to cook.
- The application filters out recipes that require more time than the specified limit.
- Both prep time and cook time are considered in the filtering process.

### 3. I want to see detailed information about each recipe, so I can decide which meal to prepare.

- Recipe cards display the following details:
- Recipe title
- An image of the dish
- Prep time and cook time
- A list of required ingredients
- Ingredients that match the user’s input are visually highlighted.
