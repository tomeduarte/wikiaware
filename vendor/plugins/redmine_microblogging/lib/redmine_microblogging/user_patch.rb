module RedmineMicroblogging
  module UserPatch

    def self.included(base) # :nodoc:
      # Exectue this code at the class level (not instance level)
      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development

        has_many :posts, :class_name => 'Post'
      end #base.class_eval

    end #self.included
  end
end

