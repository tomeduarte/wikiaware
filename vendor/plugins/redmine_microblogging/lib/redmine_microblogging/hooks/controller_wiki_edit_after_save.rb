module RedmineLinks
	 class Hooks 
		class ControllerWikiEditAfterSaveHook < Redmine::Hook::ViewListener
			def controller_wiki_edit_after_save(context={ })			
				Link.delete_all(["origem = ?", context[:params][:page]])
				
				parsed=parseLinks(context[:params][:content][:text]) 

				parsed.uniq.each do |str|
						link = Link.new(			
								:origem => context[:params][:page],  #vai buscar o nome da pagina
								:destino => str
						)
						link.save		
				end
# grupo 5
        @page = context[:page]
        subscriptions = Subscription.find(:all, :conditions => ['page_id = ?', @page.id])
        subscriptions.each do |sub|
          n = Notification.new
          n.subscription_id = sub.id
          n.read = false
          n.save
        end 
# / grupo 5
			end
			
			
	def parseLinks(texto={})	
				arrayAux = Array.new
				arrayLinks = Array.new

				arrayAux = texto.split("]]")
				arrayAux.each do |s|
					if s.index("[[") != nil 
						sAux = s.split("[[").at(1)
						if sAux.index("|") != nil
							arrayLinks.push( sAux.split("|").at(0).gsub(/[\s]+/,"_"))
						else
							arrayLinks.push(sAux.gsub(/[\s]+/,"_"))		
						end
				    end
					
				end
				
				return arrayLinks
	end
		end
	 end
end 
