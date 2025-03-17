Rails.application.routes.draw do
  draw :authentication

  root "passwords#edit"

  resources :lists do
    resources :items
  end

  get "up" => "rails/health#show", :as => :rails_health_check
end
