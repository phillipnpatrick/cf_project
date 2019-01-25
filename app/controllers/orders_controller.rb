class OrdersController < ApplicationController
    before_action :authenticate_user!
    
    def index
        if (signed_in? && current_user.admin?)
            @orders = Order.includes(:product).all
        else
            redirect_to products_url, alert: 'Unauthorized access'
        end
    end
    
    def show
        @order = Order.find(params[:id])
    end
    
    def new
    end
    
    def create
    end
    
    def destroy
    end
end