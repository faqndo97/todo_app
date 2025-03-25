Rails.application.routes.draw do
  draw :authentication

  root "accounts#show"

  resources :lists, except: :show do
    resources :items
    resources :memberships, module: :lists
  end

  resource :account, only: %i[show edit update]

  get "up" => "rails/health#show", :as => :rails_health_check
end
