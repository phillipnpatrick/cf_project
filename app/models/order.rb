class Order < ApplicationRecord
    belongs_to :product, touch: true
    belongs_to :user
    
    after_save :clear_cache
    
    def clear_cache
        $redis.del "orders"
        logger.debug "DEBUG: Order->clear_cache: orders deleted"
    end
end