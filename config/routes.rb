Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :products, only: [] do
      resources :design_configurations, except: [:show]
    end

    resources :design_configurations, only: [] do
      resources :design_options, except: [:show] do
        collection do
          post :update_positions
        end
      end
    end

    resources :design_options, only: [] do
      resources :design_option_images, except: [:show], as: :images do
        collection do
          post :update_positions
        end
      end
    end

    resources :users, only: [] do
      get :designs, on: :member
    end
  end

  namespace :api, defaults: { format: 'json' } do
    resources :templates, only: [:show, :index] do
      get :tags, on: :collection
    end


    resources :designs do
      get :mine, on: :collection
    end
    get '/cart_design/:line_item_id', to: "designs#cart_design"

    resources :template_designs, only: [:index, :create, :update, :show]

    # todo refactor into designs resources routes
    get 'designs/user/:user_id', to: "designs#user"
    put 'orders/:order_id/line_items/:id/design', to: "line_items#set_design"
    delete 'orders/:order_id/line_items/:id/design', to: "line_items#remove_design"

  end

  # controller 'spree/api/designs' do
  #   match 'http://localhost:3002/api/designs/', :to => 'spree/api/designs#route_options', via: [:options]
  # end
end
