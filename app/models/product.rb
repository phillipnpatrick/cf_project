class Product < ApplicationRecord
    has_many :orders
    has_many :comments
    
    def self.search(original_url, search_term)
        
        if original_url.include?("amazonaws.com")
            puts "wacka wacka"
            Product.where("name LIKE ?", "%#{search_term}%")
        else
            Product.where("name ilike ?", "%#{search_term}%")
        end
        
    end
    
    def highest_rating_comment
        comments.rating_desc.first
    end
    
    def lowest_rating_comment
        comments.rating_asc.first
    end
end
