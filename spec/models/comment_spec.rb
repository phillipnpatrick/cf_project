require 'rails_helper'

describe Product do
    let(:product) { Product.create!(name: "fancy afghan") }
    let(:user) { User.create!(email: "harry.potter@hogwarts.edu", password: "goldensnitch") }
    
    it "is valid with a product, user, body and rating present" do
        expect(Comment.new(product: product, user: user, body: "Awesome!", rating: 5)).to be_valid
    end
    
    it "is not valid without a product" do
        expect(Comment.new(user: user, body: "Awesome!", rating: 5)).to_not be_valid
    end
    
    it "is not valid without a user" do
        expect(Comment.new(product: product, body: "Awesome!", rating: 5)).to_not be_valid
    end
    
    it "is not valid without a body" do
        expect(Comment.new(product: product, user: user, rating: 5)).to_not be_valid
    end
    
    it "is not valid without a rating" do
        expect(Comment.new(product: product, user: user, body: "Awesome!")).to_not be_valid
    end
    
    it "is not valid with a rating that is not a number" do
        expect(Comment.new(product: product, user: user, body: "Awesome!", rating: "stupid")).to_not be_valid
    end
    
    it "is not valid without any parameters" do
        expect(Comment.new()).to_not be_valid
    end
end