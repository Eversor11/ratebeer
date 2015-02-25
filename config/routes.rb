Ratebeer::Application.routes.draw do
  resources :styles

  resources :memberships do
    post 'activate', on: :member
  end

  resources :beer_clubs

  resources :beers

  get 'auth/:provider/callback', to:'sessions#create_oauth'

  get 'ngbeerlist', to:'beers#nglist'

  get 'beerlist', to:'beers#list'

  resources :breweries do
    post 'toggle_activity', on: :member
  end

  get 'brewerylist', to:'breweries#list'

  resources :users do
    post 'toggle_frozn', on: :member
  end

  resource :session, only: [:new, :create, :delete]

  resources :places, only: [:index, :show]

  root 'breweries#index'

  get 'signup', to:'users#new'

  get 'signin', to:'sessions#new'
  delete 'signout', to:'sessions#destroy'

  post 'places', to:'places#search'

  #get 'ratings', to:'ratings#index'

  #get 'ratings/new', to:'ratings#new'

  #post 'ratings', to:'ratings#create'

  resources :ratings, only: [:index, :new, :create, :destroy]

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
