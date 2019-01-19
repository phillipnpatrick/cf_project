class UserMailer < ApplicationMailer
    default from: "from@homeknits.com"

    def contact_form(email, name, message)
        # puts "DEBUG: Inside contact_form method"
        
        # puts "DEBUG: name is #{name}"
        # puts "DEBUG: email is #{email}"
        # puts "DEBUG: message is #{message}"
        
        @message = message
        @subject = "Home Knits message from #{name}"
        @name = name
        mail(from: email, to: 'phillip.n.patrick@gmail.com', subject: @subject)
    end
    
    def order_confirmation(user, product)
        @product = product
        @appname = "Home Knits"
        mail(to: user.email, subject: "Order confirmation from the #{@appname} online store")
    end
    
    def welcome(user)
        @appname = "Home Knits"
        mail(to: user.email, subject: "Welcome to #{@appname}!")
    end
end
