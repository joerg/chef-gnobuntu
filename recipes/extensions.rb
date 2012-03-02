package "gnome-tweak-tool"

ppa "webupd8team/gnome3"

%w( gnome-shell-classic-systray gnome-shell-extension-notesearch gnome-shell-extension-window-buttons gnome-shell-extensions-autohidetopbar gnome-shell-extensions-extended-places-menu gnome-shell-extensions-hamster gnome-shell-extensions-mediaplayer gnome-shell-extensions-noa11y gnome-shell-extensions-pidgin gnome-shell-extensions-weather gnome-shell-extensions-windowoverlay-icons gnome-shell-message-notifier gnome-shell-system-monitor ).each do |p|
  package p
end if node[:gnobuntu][:gnome_extensions]
 
#mailnag 

%w( mgse-bottompanel mgse-menu mgse-windowlist ).each do |p|
  package p
end if node[:gnobuntu][:mint_extensions]
