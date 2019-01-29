class SimplePagesController < ApplicationController
  def index
  end
  
  def landing_page
    @products = Product.limit(5)
    
    # $redis.set("carousel-items", @products.size) #Error connecting to Redis on localhost:6379 (Errno::ECONNREFUSED)
  end
  
  def thank_you
      logger.debug "Inside thank_you method (simple_pages_controller)"
      
      @name = params[:name]
      @email = params[:email]
      @message = params[:message]
      
      logger.debug "name is #{@name}"
      logger.debug "email is #{@email}"
      logger.debug "message is #{@message}"
      
      UserMailer.contact_form(@email, @name, @message).deliver_now
  end
end
