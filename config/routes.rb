Rails.application.routes.draw do

  scope module: "public" do
   root :to => "homes#top"
   get "about" => "homes#about"
   resource :customers, only: [:show, :edit, :update]
   get "customers/unsubscribe" => "customers#unsubscribe"
   patch "customers/withdraw" => "customers#withdraw"


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
   resources :orders, only: [:show, :update]
   resources :order_details, only: [:update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
