require 'gtk3'

Gtk.init

load "Ecran_jeu.rb"
load "Ecran_menu.rb"

##
# Création de la fenetre
win = Gtk::Window.new()
win.set_title("FILL A PIX")
#win.maximize
win.fullscreen
#win.set_default_size(1000, 500)


win.signal_connect('destroy'){
    Gtk.main_quit
}

Ecran_menu.creer(win)