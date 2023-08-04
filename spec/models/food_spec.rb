require 'rails_helper'

RSpec.describe Food, type: :model do
  describe 'associations' do
    it 'It should have multiple recipe_foods associated with it' do
      expect(Food.reflect_on_association(:recipe_foods).macro).to eq(:has_many)
    end

    it 'It must be associated with a user' do
      expect(Food.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    let(:user) { User.create(name: 'anything', email: 'anything@email.com', password: 'anything') }
    let(:food) { Food.new(name: 'food', measurement_unit: 'unit', quantity: 10, price: 10, user:) }

    it 'should be valid' do
      expect(food).to be_valid
    end

    it 'It should be valid even without a name' do
      food.name = nil
      expect(food).not_to be_valid
    end

    it 'The name should be limited to 250 characters or less' do
      food.name = 'a' * 251
      expect(food).not_to be_valid
    end

    it 'should not be valid for a quantity' do
      food.quantity = nil
      expect(food).not_to be_valid
    end

    it 'should not be valid for a measurement_unit' do
      food.measurement_unit = nil
      expect(food).not_to be_valid
    end

    it 'should not be valid for a price' do
      food.price = nil
      expect(food).not_to be_valid
    end
  end
end
