Rails.application.routes.draw do
  devise_for :users
  resources :users do
    collection do
      post :search
      get :search
    end
  end

  resources :responses do
    collection do
      post :filter
      get :filter
      post :init_survey
    end
  end
  
  resources :media_socials

  post '/add_user' => "users#create"
  put "/profiles" => "users#update_profile"
  get "/profile" => "users#profile"

  get "set_language/change_locale"

  root 'dashboard#index'

  resources :surveys do
    collection do
      post :filter
      get :filter

      get "status/:id" => "surveys#force_status", as: :force

      post :get_view
      get :reload
      post :reorder
      get :question_list
      get "preview/:id" => "surveys#preview", as: :preview
      get :add_row
      get :set_enable
      get :set_survey_session
      get :question_detail
      get :question_page
      get :reset_session
      
      post :set_question
      get :edit_question
      get :add_question
      get "manage_question/:section" => "surveys#manage_question", as: :manage_question
      post "manage_question/:section" => "surveys#manage_question", as: :manage_question_post
      
      post :set_logical
      get :edit_logical
      get :add_logical
      get "manage_logical/:section" => "surveys#manage_logical", as: :manage_logical
      post "manage_logical/:section" => "surveys#manage_logical", as: :manage_logical_post
      
      post :set_page
      get :edit_page
      get :add_page
      get "manage_page/:section" => "surveys#manage_page", as: :manage_page
      post "manage_page/:section" => "surveys#manage_page", as: :manage_page_post
    end
  end

  # resources :surveys do
  #   collection do
  #     post :submit_question
  #     post :submit_background
  #     post :submit_page
  #     get :background_page
  #     get :page_preview
  #     get :pull_question_title
  #     post :duplicate_question
  #     post :delete_question
  #     post :update_logic
  #     get :form_logical
  #     get :get_question_page
  #     get :reset_session
  #   end
  # end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
