class Post < ActiveRecord::Base
  unloadable

  belongs_to :user
end

