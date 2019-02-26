class Product < ApplicationRecord
    has_many :orders
    has_many :comments
    validates :name, presence: true
    
    def self.search(original_url, search_term)
        
        if Rails.env.production?
            Product.where("name ilike ?", "%#{search_term}%")
        else
            Product.where("name LIKE ?", "%#{search_term}%")
        end
        
    end
    
    def highest_rating_comment
        # Rails.cache.fetch([cache_key, __method__], expires_in: 30.minutes) do
            comments.rating_desc.first
        # end
    end
    
    def lowest_rating_comment
        # Rails.cache.fetch([cache_key, __method__], expires_in: 30.minutes) do
            comments.rating_asc.first
        # end
    end
    
    def average_rating
        # Rails.cache.fetch([cache_key, __method__], expires_in: 30.minutes) do
            comments.average(:rating).to_f
        # end
    end
end
