module RedmineMicroblogging
  module UserPatch

    def self.included(base) # :nodoc:
      # Exectue this code at the class level (not instance level)
      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development

        has_many :posts, :class_name => 'Post'
        has_many :friendships
        has_many :friends, :through => :friendships
        has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
        has_many :inverse_friends, :through => :inverse_friendships, :source => :user
      end #base.class_eval

    end #self.included
  end
end

