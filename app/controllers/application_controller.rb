class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
   
   def after_sign_in_path_for(resource)
     case resource
     when Admin
       admin_root_path
     when Customer
       customers_path
     end
   end
          
  
   protected
       #新規登録保存機能
     def configure_permitted_parameters
       devise_parameter_sanitizer.permit(:sign_up,
       keys: [:first_name, :last_name, :kana_first_name, :kana_last_name, 
       :email, :postal_code, :residence, :phone_number])
        #sign_upの際にnaameのデータ操作を許可。追加したカラム
       devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
     end  
end
