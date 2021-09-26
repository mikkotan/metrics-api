Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :metrics, except: :show do
        resources :values, except: [:show, :update]
      end
    end
  end
end
