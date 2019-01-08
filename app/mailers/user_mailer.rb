class UserMailer < ApplicationMailer
    default from: "phillip.n.patrick@gmail.com"
    
    def contact_form(email, name, message)
        @name = name
        @message = message
        mail(
            from: email,
            to: 'phillip.n.patrick@gmail.com',
            subject: "Home Knits message from #{@name}")
    end
end
