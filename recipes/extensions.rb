package "gnome-tweak-tool"

ppa "webupd8team/gnome3"

%w( gnome-shell-classic-systray gnome-shell-extension-notesearch gnome-shell-extension-window-buttons gnome-shell-extensions-autohidetopbar gnome-shell-extensions-extended-places-menu gnome-shell-extensions-hamster gnome-shell-extensions-mediaplayer gnome-shell-extensions-noa11y gnome-shell-extensions-pidgin gnome-shell-extensions-weather gnome-shell-extensions-windowoverlay-icons gnome-shell-message-notifier gnome-shell-system-monitor gnome-shell-extensions-alternate-tab gnome-shell-extensions-alternative-status-menu gnome-shell-extensions-apps-menu gnome-shell-extensions-auto-move-windows gnome-shell-extensions-common gnome-shell-extensions-dock gnome-shell-extensions-drive-menu gnome-shell-extensions-gajim gnome-shell-extensions-native-window-placement gnome-shell-extensions-places-menu gnome-shell-extensions-system-monitor gnome-shell-extensions-user-theme gnome-shell-extensions-windows-navigator gnome-shell-extensions-workspace-indicator gnome-shell-extensions-xrandr-indicator ).each do |p|
  package p
end if node[:gnobuntu][:gnome_extensions]
 
#mailnag 

%w( mgse-bottompanel mgse-menu mgse-windowlist ).each do |p|
  package p
end if node[:gnobuntu][:mint_extensions]
