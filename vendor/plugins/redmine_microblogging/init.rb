require 'redmine'

Redmine::Plugin.register :redmine_microblogging do
  name 'Redmine Microblogging plugin'
  author 'Grupo5'
  description 'This is a plugin for Redmine to enable a microblogging feature'
  version '0.0.1'
  url 'http://ihuru.fe.up.pt/ldso/1011/doku.php'
  menu :application_menu, :posts, {:controller=>'posts', :action=>'index'}, :caption=>'Microblogging'
end

