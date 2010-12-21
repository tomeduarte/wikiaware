module RedmineMicroblogging
  module UserPatch

    def self.included(base) # :nodoc:
      # Exectue this code at the class level (not instance level)
      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development

        has_many :posts, :class_name => 'Post'
        has_many :friendships
        has_many :friends, :through => :friendships, :conditions => ["friendships.accepted = ? AND friendships.blocked = ?", true, false]
        has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
        has_many :inverse_friends, :through => :inverse_friendships, :source => :user
        has_many :subscriptions

        def self.search(search)
          if search
            find(:all, :conditions => ['login LIKE ? OR firstname LIKE ? OR mail LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
          end
        end
      end #base.class_eval

    end #self.included
  end # user
  module WikiPagePatch
    def self.included(base)
      base.send(:include, InstanceMethods)

      base.class_eval do
        unloadable

        has_many :subscriptions

        after_destroy :remove_subscription
      end #base.class_eval
    end # self.included
  
    module ClassMethods
    end

    module InstanceMethods
      # this removes the subscription to a deleted page
      # and creates a notification for the subscribers
      def remove_subscription
        desc_text = "\"#{self.title}\" from project #{self.project.name} "

        subscriptions = Subscription.find(:all, :conditions => ['page_id = ?', self.id])
        subscriptions.each do |sub|
          # update all the notifications for this wiki page
          notifications = Notification.find(:all, :conditions => ['subscription_id = ?', sub.id])
          notifications.each do |notification|
            desc = notification.description
            notification.description = desc_text + desc
            notification.save
          end
          # create notification for deletion
          n = Notification.new
          n.subscription_id = sub.id
          n.description = "#{desc_text} was deleted"
          n.read = false
          n.save
          # remove subscription
          sub.destroy
        end 
      end
    end
  end # wikipage
end

