gnome = %w( gnome-shell alsa-base alsa-utils anacron at-spi2-core baobab bc ca-certificates dmz-cursor-theme doc-base eog evince file-roller gcalctool gedit genisoimage ghostscript-x gnome-control-center gnome-font-viewer gnome-media gnome-menus gnome-nettool gnome-power-manager gnome-screenshot gnome-session gnome-session-canberra gnome-system-log gnome-system-monitor gnome-terminal gstreamer0.10-alsa gstreamer0.10-plugins-base-apps gstreamer0.10-pulseaudio gucharmap gvfs-bin inputattach language-selector-gnome libatk-adaptor libatk-adaptor-schemas libgd2-xpm libnotify-bin libpam-ck-connector libsasl2-modules libsdl1.2debian libxp6 nautilus notify-osd pulseaudio rarian-compat rfkill seahorse  software-properties-gtk ssh-askpass-gnome system-config-printer-gnome ttf-dejavu-core ttf-freefont ubuntu-artwork ubuntu-extras-keyring ubuntu-sounds unzip wireless-tools wpasupplicant xdg-user-dirs xdg-user-dirs-gtk xdiagnose xkb-data xorg xterm yelp zenity zip acpi-support aisleriot app-install-data-partner apport-gtk bluez bluez-alsa bluez-gstreamer branding-ubuntu brasero brltty cmap-adobe-japan2 cups-client empathy firefox firefox-gnome-support fonts-kacst-one fonts-khmeros-core fonts-lao fonts-liberation fonts-nanum fonts-takao-pgothic fonts-thai-tlwg gcc ginn gnome-accessibility-themes gnome-bluetooth gnome-disk-utility gnome-orca gnome-screensaver gnome-sudoku gnomine gvfs-fuse gwibber ibus ibus-gtk3 ibus-pinyin ibus-pinyin-db-android ibus-table im-switch kerneloops-daemon laptop-detect libgail-common libpam-gnome-keyring libproxy1-plugin-gsettings libproxy1-plugin-networkmanager libreoffice-calc libreoffice-gnome libreoffice-help-en-us libreoffice-impress libreoffice-math libreoffice-style-human libreoffice-writer libwmf0.2-7-gtk linux-headers-generic-pae mahjongg make mousetweaks nautilus-share network-manager-gnome network-manager-pptp network-manager-pptp-gnome onboard pcmciautils plymouth-theme-ubuntu-logo policykit-desktop-privileges pulseaudio-module-bluetooth pulseaudio-module-gconf pulseaudio-module-x11 python-aptdaemon.pkcompat qt-at-spi remmina rhythmbox shotwell simple-scan sni-qt speech-dispatcher telepathy-idle thunderbird thunderbird-gnome-support totem totem-mozilla transmission-gtk ttf-indic-fonts-core ttf-punjabi-fonts ttf-ubuntu-font-family ttf-wqy-microhei ubuntu-docs usb-creator-gtk vino xcursor-themes xdg-utils xul-ext-ubufox )

execute "fix-dpkg" do
  command "dpkg-reconfigure -a -u"
  action :nothing
end

package "xserver-xorg" do
  notifies :run, resources(:execute => "fix-dpkg")
end

gnome.each do |p|
  package p
end

%w( ubuntu ubuntu-2d ).each do |f|
  file "/usr/share/gnome-session/sessions/#{f}.session"  do
    action :delete
  end
  file "/usr/share/xsessions/#{f}.desktop" do
    action :delete
  end
end

package node[:gnobuntu][:display_manager] do
  notifies :run, resources(:execute => "fix-dpkg")
end

%w( avahi-autoipd avahi-daemon libnss-mdns ).each do |p|
  package p do
    action (node[:gnobuntu][:avahi]) ? :install : :purge
  end
end

%w( launchpad-integration software-center jockey-gtk rhythmbox-ubuntuone ubuntuone-client-gnome ubuntuone-control-panel-gtk whoopsie deja-dup overlay-scrollbar activity-log-manager-control-center activity-log-manager-common ).each do |p|
  package p do
    action (node[:gnobuntu][:cannonical]) ? :install : :purge
  end
end
  
%w( update-manager update-notifier ).each do |p|
  package p do
    action (node[:gnobuntu][:updater]) ? :install : :purge
  end
end

%w( foomatic-db-compressed-ppds foomatic-filters openprinting-ppds printer-driver-pnm2ppa cups cups-bsd hplip printer-driver-c2esp printer-driver-foo2zjs printer-driver-min12xxw printer-driver-ptouch printer-driver-pxljr printer-driver-sag-gdi printer-driver-splix bluez-cups ).each do |p|
  package p do
    action (node[:gnobuntu][:printer]) ? :install : :purge
  end
end

include_recipe "gnobuntu::extensions" if node[:gnobuntu][:shell_extensions]
