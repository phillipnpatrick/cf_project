class UserMailer < ApplicationMailer
    require 'sendgrid-ruby'
    include SendGrid
    
    default from: "phillip.n.patrick@gmail.com"
    
    def contact_form(email, name, message)
        @name = name
        @message = message
        # mail(
        #     from: email,
        #     to: 'phillip.n.patrick@gmail.com',
        #     subject: "Home Knits message from #{@name}")
        from = SendGrid::Email.new(email: 'phillip.n.patrick@gmail.com')
        to = SendGrid::Email.new(email: 'phillip.n.patrick@gmail.com')
        subject = "Home Knits message from #{@name}"
        content = SendGrid::Content.new(type: 'text/html', value: @message)
        mail = SendGrid::Mail.new(from, subject, to, content)
        
        sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
        response = sg.client.mail._('send').post(request_body: mail.to_json)
        puts response.status_code
        puts response.body
        puts response.headers
    end
end
