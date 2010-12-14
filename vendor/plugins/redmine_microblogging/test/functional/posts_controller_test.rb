require File.expand_path(File.join(File.dirname(__FILE__), '../test_helper'))

class PostsControllerTest < ActionController::TestCase

  context "routes" do
    should_route  :get, '/posts', :controller => 'posts', :action => 'index'
  end
end
