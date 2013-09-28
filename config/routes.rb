SampleApp::Application.routes.draw do
  get "users/new"
  root 'static_pages#home'
  match 'static_pages/help', to: 'static_pages#help', as: 'help', via: 'get'
  match 'static_pages/home', to: 'static_pages#home', as:'home', via: 'get'
  match 'static_pages/about', to: 'static_pages#about', as: 'about' ,via: 'get'
  match 'static_pages/contact', to: 'static_pages#contact', as: 'contact' ,via: 'get'
  match '/signup', to: 'users#new', via: 'get'
  #Okay, I've figured out that
  #match means match the request 'static_pages/help' on a get request.
  #-->This is the user incoming request!
  #So http://127.0.0.1:3000/static_pages/help on a 'get' request will be
  #managed in the to: section. In this case, 'static_pages#help' means
  #Use the static_pages controller and def help action in the controller
  #which of course, routes to the help view.
  #It appears, the 'as:' really is rails magic.  In the views, when it looks for
  #'help_path' or 'help_url', it is looking for the "as: 'help'"
  #here to find the right controller/action
  #
  #
  #

  #READ THIS LATER!!!
  #http://www.dreamincode.net/forums/topic/157760-rails-routes-explained-part-2/

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
