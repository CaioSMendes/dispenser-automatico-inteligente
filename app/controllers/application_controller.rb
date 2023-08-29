class ApplicationController < ActionController::Base
    before_action :authenticate_user!, except: [:login, :register]
    before_action :configure_permitted_parameters, if: :devise_controller?


    def index
        # Adicione o código necessário para a página admin/index aqui
    end


    def after_sign_in_path_for(resource)
        if resource.admin?
          admin_index_path	
        else
          user_index_path	
        end
    end

    protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone])
  end
end