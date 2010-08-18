ActionController::Routing::Routes.draw do |map|
  map.root      :controller=>'pages', :action=> 'home'
  map.resources :uploads
  map.about     '/about', :controller=>'pages', :action=>'about'
  map.upload    '/upload',:controller=>'uploads',:action=>'new'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
