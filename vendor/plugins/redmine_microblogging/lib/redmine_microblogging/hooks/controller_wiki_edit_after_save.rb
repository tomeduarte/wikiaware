module RedmineLinks
	 class Hooks 
		class ControllerWikiEditAfterSaveHook < Redmine::Hook::ViewListener
			def controller_wiki_edit_after_save(context={ })			
        @page = context[:page]
        subscriptions = Subscription.find(:all, :conditions => ['page_id = ?', @page.id])
        subscriptions.each do |sub|
          n = Notification.new
          n.subscription_id = sub.id
          n.read = false
          n.save
        end 
			end
		end
	 end
end 
