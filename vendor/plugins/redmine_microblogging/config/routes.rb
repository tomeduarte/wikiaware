ActionController::Routing::Routes.draw do |map|
  map.resources :posts

  map.resources :friendships,
    :member => { :accept => :get, :block => :get, :reject => :get }

  map.resources :subscriptions, :only => [:index, :create, :destroy]
end

