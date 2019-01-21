require 'rails_helper'

describe Product do
    let(:product) { Product.create!(name: "fancy afghan") }
        # create! will raise an exception
        # create! is a combo of .new and .save!
        
    let(:user) { User.create!(email: "harry.potter@hogwarts.edu", password: "goldensnitch") }
    
    before do
        product.comments.create!(rating: 1, user: user, body: "Cheap yarn!")
        product.comments.create!(rating: 3, user: user, body: "I wish it kept me warmer!")
        product.comments.create!(rating: 5, user: user, body: "I'm ordering one for everyone I know!")
    end
    
    it "returns the highest rating of all comments" do
        expect(product.highest_rating_comment.rating).to eq 5
    end
    
    it "returns the lowest rating of all comments" do
        expect(product.lowest_rating_comment.rating).to eq 1
    end
    
    it "returns the average rating of all comments" do
        expect(product.average_rating).to eq 3
    end
    
    it "is not valid without a name" do
        expect(Product.new(description: "Hogwarts Afghan")).not_to be_valid
        #new => generate new product in memory (doesn't store to db)
    end
end