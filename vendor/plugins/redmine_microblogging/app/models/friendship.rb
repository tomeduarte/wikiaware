class Friendship < ActiveRecord::Base
  unloadable
  belongs_to :user
  belongs_to :friend, :class_name => "User"

end

