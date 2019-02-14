class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_account_update_params, only: [:update]

  def new
    super do|resource|
      if params[:inviter]
        resource.inviter = params[:inviter]
      end
    end
  end

  def create
    code = params[:confirm_code]
    if code == cookies[:reg_code]
      super do |resource|
        if resource.persisted? and resource.inviter != ""
          user_inviter = User.find_by_number(resource.inviter)
          if user_inviter
            resource.update_attribute(:parent_id, user_inviter.id)
          end
        end
      end
    else
      redirect_to new_user_registration_url
    end
  end

  def after_sign_up_path_for(resource)
    root_url
  end



  #def after_inactive_sign_up_path_for(resource)
  #  sendmail_users_url
  #end
  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
