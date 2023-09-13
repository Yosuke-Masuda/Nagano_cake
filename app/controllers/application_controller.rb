class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
   
   def after_sign_in_path_for(resource)
     case resource
     when Admin
       admin_root_path
     when Customer
       root_path
     end
   end
   
   def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :customer
     root_path
    elsif resource_or_scope == :admin
     new_admin_session_path
    else
     root_path
    end
      
   end 
          
  
   protected
       #新規登録保存機能
     def configure_permitted_parameters
       devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :first_name, :last_name, :first_name_kana, :last_name_kana, :email, :postal_code, :encrypted_password, :phone_number, :address])
        #sign_upの際にnaameのデータ操作を許可。追加したカラム
       devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
     end  
end
