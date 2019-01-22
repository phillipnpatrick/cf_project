require 'rails_helper'

describe Product do
    product = FactoryBot.build(:product)
    user = FactoryBot.create(:user)
    
    it "is valid with a product and a user" do
        expect(Order.new(product: product, user: user)).to be_valid
    end
    
    it "is not valid without a product" do
        expect(Order.new(user: user)).to_not be_valid
    end
    
    it "is not valid without a user" do
        expect(Order.new(product: product)).to_not be_valid
    end
    
    it "is not valid without a product and without a user" do
        expect(Order.new()).to_not be_valid
    end
end