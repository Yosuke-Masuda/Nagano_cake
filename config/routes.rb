Rails.application.routes.draw do

  scope module: :public do
   root :to => "homes#top"
   get "about" => "homes#about"
   resource :customers, only: [:show, :edit, :update]
   get "customers/my_page" => "customers#show"
   get "customers/unsubscribe" => "customers#unsubscribe"
   patch "customers/withdraw" => "customers#withdraw"

   resources :addresses, except: [:show, :new]
   
   resources :items, only: [:index, :show]
   
   resources :cart_items, only: [:index, :update, :create, :destroy] do
      collection do
        delete 'destroy_all'
      end
   end
    
   resources :orders, only: [:index, :show, :new, :create] do
      collection do
        post 'confirm'
        get 'complete'
      end
   end



  end


  devise_for :admins, path: "/admin", controllers: {
    sessions: 'admin/sessions'

  }

 scope module: :public do
    devise_for :customers, controllers: {
      sessions: 'public/sessions',
      passwords: 'public/passwords',
      registrations: 'public/registrations'
    }
 end





  namespace :admin do
   root :to => 'homes#top'
   resources :genres, only: [:index, :create, :edit, :update]
   resources :items, only: [:index, :new, :create, :show, :edit, :update]
   resources :customers, only: [:index, :show, :edit, :update]
   resources :orders, only: [ :show, :update] do
      patch "admin/order_details/:id" => "order_details#update", as: "order_detail"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
