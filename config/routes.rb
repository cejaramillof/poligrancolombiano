Rails.application.routes.draw do
  resource :cart, only: [:show]
  resources :estimate_foods, only: [:create, :update, :destroy]
  resources :foods, only: [:create, :destroy, :new]
  resources :food_types, except: [:index]
  resources :food_groups
  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :estimates, except: [:update, :edit] do
    resource :download, only: [:show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'welcome/index'
  get 'welcome/perfil'
  put 'admin/users/:id/approve', to: "users#approve", as: :approve_user
  scope "/admin" do
    resources :users, except: [:show, :destroy, :new, :create]
  end
  authenticated :user do
    root :to => 'estimates#index', as: :authenticated_root
  end

  unauthenticated :user do
    devise_scope :user do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
