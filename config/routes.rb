Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check

  resources :projects do 
    resources :tasks
  end

end
