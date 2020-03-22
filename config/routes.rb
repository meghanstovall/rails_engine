Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      get "/revenue", to: "revenue#total_revenue"

      namespace :items do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
      end

      resources :items, except: [:new, :edit] do
        scope module: 'items' do
          get "/merchant", to: "merchants#show"
        end
      end

      namespace :merchants do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
        get "/most_revenue", to: "revenues#index"
        get "/most_items", to: "revenues#most_items"
        get "/:id/revenue", to: "revenues#show"
      end

      resources :merchants, except: [:new, :edit] do
        scope module: 'merchants' do
          get "/items", to: "items#index"
        end
      end
    end
  end
end
