# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class TeamMembersExtension < Radiant::Extension
  version "0.1"
  description "The team members extension gives you a model for creating team members"
  url "http://www.tribesmen.de"
  
  define_routes do |map|
     map.namespace :admin do |admin| #, :member => { :remove => :get } do |admin|
       admin.resources :team_members
     end
   end
  
  def activate
    admin.tabs.add "Team Members", "/admin/team_members", :after => "Layouts", :visibility => [:all]
	 Page.send :include, TeamMembers
  end
  
  def deactivate
    admin.tabs.remove "Team Members"
  end
  
end
