# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
   def create
     # User[:flag]=true
     # @usr=User.find(params[:id])
     # @usr.flag=true
     # User.params[:flag]=true
     # @user.flag=true
     super
   end

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
  # def configure_sign_up_params
  #    devise_parameter_sanitizer.permit(:first_name, :sign_up, keys: [:attribute])
  #    # params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :address, :contact_number, :user_role)
  # end
  def sign_up_params
      params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation, :address, :contact_number, :user_role)
  end

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
