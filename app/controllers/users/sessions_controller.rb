module Users
  class SessionsController < Devise::SessionsController
   def new
       self.resource = resource_class.new(sign_in_params)
       store_location_for(resource, params[:redirect_to])
    #   byebug
       super
   end
  end
end