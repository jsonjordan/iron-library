Rails.application.routes.draw do

  root 'books#index'

  get 'books' => 'books#index'
  get '/campus/:campu_id/books/confirm' => 'books#confirm', as: 'book_confirm'
  get '/campus/:campu_id/books' => 'books#campus_index'
  get '/users/:user_id/checkouts' => 'checkouts#user_index', as: 'user_checkouts'
  get '/campus/:campu_id/checkouts' => 'checkouts#campus_index', as: 'campus_checkouts'
  get '/users/:user_id/check_in' => 'checkouts#check_in', as: 'user_check_in'
  get '/books/:book_id/reservations' => 'reservations#book_index', as: 'book_reservations'
  get '/users/:user_id/reservations' => 'reservations#user_index', as: 'user_reservations'
  get '/users/purchase_requests' => 'purchase_requests#user_index', as: 'user_purchase_requests'


  devise_for :users, :controllers => { :registrations => 'plock' }

  resources :campus do
    resources :books, except: [:index], shallow: true do
      resources :reviews, except: [:show, :index], shallow: true
      resources :checkouts, except: [:destroy, :new, :edit], shallow: true
      resources :reservations, only: [:create, :destroy], shallow: true
    end
    resources :purchase_requests, shallow: true
  end

  resources :users, only: [:index, :show]

  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user

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
