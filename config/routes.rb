Rails.application.routes.draw do
    
  devise_for :admins, path: "/admin", controllers: {
    sessions: 'admin/sessions'
            
  }
  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    passwords: 'customers/passwords',
    registrations: 'customers/registrations'
  }

  
    

  namespace :admin do
   root :to => 'homes#top'
   resources :genres, only: [:index, :create, :edit, :update]
   resources :items, only: [:index, :new, :create, :show, :edit, :update]
   resources :customers, only: [:index, :show, :edit, :update]
   resources :orders, only: [:show, :update]
   resources :order_details, only: [:update]
  end
  
  scope module: "public" do
   root :to => "homes#top"
   get "about" => "homes#about"
   resource :customers, only: [:edit, :update] do
   get "my_page" => "customers#show"
   get "out_confirm"
   patch "out"
   end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
