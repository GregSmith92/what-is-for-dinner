require 'rails_helper'

RSpec.describe IngredientParser do
  describe '.parse' do
    ingredient_parsing_expectations = {
      "1 teaspoon salt"               => ["1 teaspoon", "salt"],
      "3 ½ teaspoons baking powder"   => ["3 ½ teaspoons", "baking powder"],
      "2 teaspoons ground cinnamon"   => ["2 teaspoons", "ground cinnamon"],
      "1 egg"                         => ["1", "egg"],
      "⅓ cup milk, or more as needed" => ["⅓ cup", "milk"]
    }

    it 'expects parser result to match expected outputs' do
      aggregate_failures do
        ingredient_parsing_expectations.each do |result|
          expect(described_class.parse(result.first)).to eq(result.second)
        end
      end
    end
  end
end
