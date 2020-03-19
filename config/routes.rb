Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      resources :items, except: [:new, :edit] do
        scope module: 'items' do
          get "/merchant", to: "merchants#show"
        end
      end

      resources :merchants, except: [:new, :edit] do
        scope module: 'merchants' do
          get "/items", to: "items#index"
        end
      end
    end
  end
end
