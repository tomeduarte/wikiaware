ActionController::Routing::Routes.draw do |map|
  map.resources :posts, :only => [:index, :new, :create, :destroy]
  map.resources :friendships, :only => [:create, :destroy],
    :member => { :accept => :get, :block => :get, :reject => :get }
  map.resources :subscriptions, :only => [:index, :create, :destroy]
  map.resources :notifications, :only => [:index, :update]
end

