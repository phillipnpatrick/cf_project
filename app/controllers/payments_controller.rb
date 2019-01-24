class PaymentsController < ApplicationController
    def create
        token = params[:stripeToken]
        product = Product.find(params[:product_id])
        user = current_user
        
        begin
            charge = Stripe::Charge.create(
                amount: (product.price * 100).to_i,
                currency: "usd",
                source: token,
                receipt_email: user.email,
                description: params[:stripeEmail]
            )
            
            if charge.paid
                Order.create(product_id: product.id, user_id: user.id, total: product.price)
            end
            
            # flash[:notice] = "Thank you for your purchase!"
            
            # redirect_to payments_create_path(product_id: product.id, stripeToken: token)
        rescue Stripe::CardError => e
            # Card declined
            body = e.json_body
            err = body[:error]
            flash[:error] = "Unfortunately, there was an error processing your payment: #{err[:message]}"
            redirect_to product_path(product)
        else
            # other exception
        ensure
            # always executed
        end
        
    end
end
