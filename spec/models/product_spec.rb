require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    # Initialize a category for testing
    before(:each) do
      @category = Categroy.create(name: 'Test Category')
    end

    # A Product with all fields set will save successfully
    it 'saves successfully when all fields are set' do 
      product = Product.new(
        name: 'Test Product',
        price: 100.00,
        quantity: 5,
        category: @category
      )
      expect(product.save).to be_truthy
    end

    # Name presence validation
    it 'is not valid without a name' do
      product = Product.new(
        price: 100.00,
        quantity: 5,
        category: @category
      )
      expect(product.save).to be_falsey
      expect(product.errors.full_messages).to include("Name cannot be blank")
    end

    # Price presence validation
    it 'is not valid without a price' do
      product = Product.new(
        name: 'Test Product',
        quantity: 5,
        category: @category
      )
      expect(product.save).to be_falsey
      expect(product.errors.full_messages).to include("Price cannot be blank")
    end

    # Quantity presence validation
    it 'is not valid without a quantity' do
      product = Product.new(
        name: 'Test Product',
        price: 100.00,
        category: @category
      )
      expect(product.save).to be_falsey
      expect(product.errors.full_messages).to include("Quantity cannot be blank")
    end

    # Category presence validation
    it 'is not valid without a quantity' do
      product = Product.new(
        name: 'Test Product',
        price: 100.00
        quantity: 5
      )
      expect(product.save).to be_falsey
      expect(product.errors.full_messages).to include("Category cannot be blank")
    end

  end
end
