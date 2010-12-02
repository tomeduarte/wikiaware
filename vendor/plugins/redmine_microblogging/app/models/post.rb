class Post < ActiveRecord::Base
  unloadable

  belongs_to :user
  validates_presence_of :content 
  validates_presence_of :user 
end

