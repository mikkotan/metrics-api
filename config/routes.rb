Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :metrics, except: :show
    end
  end
end
