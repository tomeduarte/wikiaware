require 'redmine'
require 'dispatcher'
require 'principal'
require 'user'
require_dependency 'redmine_microblogging/hooks/controller_wiki_edit_after_save'

Redmine::Plugin.register :redmine_microblogging do
  name 'Redmine Microblogging plugin'
  author 'Grupo5'
  description 'This is a plugin for Redmine to enable a microblogging feature'
  version '0.0.1'
  url 'http://ihuru.fe.up.pt/ldso/1011/doku.php'
  author_url 'http://ihuru.fe.up.pt/ldso/1011/doku.php?id=wikiaware'
  menu :application_menu, :posts, {:controller=>'posts', :action=>'index'}, :caption=>'Microblogging'
  menu :application_menu, :subscriptions, {:controller=>'subscriptions', :action=>'index'}, :caption=>'Subscriptions'
  menu :application_menu, :notifications, {:controller=>'notifications', :action=>'index'}, :caption=>'Notifications'
end


Dispatcher.to_prepare :redmine_microblogging do
  unless User.included_modules.include? RedmineMicroblogging::UserPatch
    User.send(:include, RedmineMicroblogging::UserPatch)
  end
end

