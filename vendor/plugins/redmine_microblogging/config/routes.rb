ActionController::Routing::Routes.draw do |map|
  map.resources :posts

  map.resources :friendships,
    :member => { :accept => :get, :block => :get }

end

