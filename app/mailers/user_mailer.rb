class UserMailer < ApplicationMailer
    default from: "from@homeknits.com"

    def contact_form(email, name, message)
        @message = message
        mail(from: email,
             to: 'phillip.n.patrick@gmail.com',
             subject: "Home Knits message from #{@name}")
    end
    
    def thank_you
        @name = params[:name]
        @email = params[:email]
        @message = params[:message]
        UserMailer.contact_form(@email, @name, @message).deliver_now
    end
    
    def order_confirmation(user, product)
        @product = product
        @appname = "Home Knits"
        mail(to: user.email, subject: "Order confirmation from the #{@appname} online store")
    end
end
