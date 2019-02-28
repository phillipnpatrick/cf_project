module OrdersHelper
    def fetch_orders
        logger.debug "DEBUG: OrdersHelper->fetch_orders"
        $redis.del "orders"
        logger.debug "DEBUG: OrdersHelper->fetch_orders just deleted orders"
        orders = $redis.get("orders")
        if orders.nil?
            logger.debug "DEBUG: OrdersHelper->fetch_orders: orders was nil"
            orders = Order.all.to_json(:include=> [:product])
            
            # how do I include product information?
            # @course.to_json(:include=> [:interaction_outline, :token_outline]
            
            $redis.set("orders", orders)
            
            # Expire the cache every 3 hours
            # $redis.expire("orders", 3.hour.to_i)
        end
        @orders = JSON.load orders
        logger.debug "DEBUG: OrdersHelper->fetch_orders: loaded orders"
    end
end