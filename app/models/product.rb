class Product < ApplicationRecord
    has_many :orders
    
    def self.search(original_url, search_term)
        
        if original_url.include?("amazonaws.com")
            puts "wacka wacka"
            Product.where("name LIKE ?", "%#{search_term}%")
        else
            Product.where("name ilike ?", "%#{search_term}%")
        end
        
    end
end
