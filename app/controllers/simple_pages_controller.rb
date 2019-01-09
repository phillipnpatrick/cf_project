class SimplePagesController < ApplicationController
  def index
  end
  
  def landing_page
    @products = Product.limit(5)
  end
  
  def thank_you
      # puts "DEBUG: Inside thank_you method (simple_pages_controller)"
      
      @name = params[:name]
      @email = params[:email]
      @message = params[:message]
      
      # puts "DEBUG: name is #{@name}"
      # puts "DEBUG: email is #{@email}"
      # puts "DEBUG: message is #{@message}"
      
      UserMailer.contact_form(@email, @name, @message).deliver_now
  end
end
