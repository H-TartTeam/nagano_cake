class Public::RegistrationsController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?

 def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :email])
 end

end

