Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :metrics do
        resources :values, except: [:show, :update]
      end
    end
  end
end
