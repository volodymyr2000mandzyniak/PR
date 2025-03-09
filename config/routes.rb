Rails.application.routes.draw do
  defaults format: :json do
    resources :projects do
      resources :tasks
    end
  end
end
