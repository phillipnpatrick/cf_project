class UserRegistrationsController < Devise::RegistrationsController
    def create
        super
        if @user.persisted?
            UserMailer.welcome(@user).deliver_now
        end
    end
    
    protected
        def after_sign_up_path_for(resource)
          signed_in_root_path(resource)
        end
    
        def after_update_path_for(resource)
          signed_in_root_path(resource)
        end
end