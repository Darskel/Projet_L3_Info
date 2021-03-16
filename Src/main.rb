require 'gtk3'

Gtk.init

load "Ecran_jeu.rb"
load "EcranJouer.rb"
load "EcranOptions.rb"
load "Ecran_aventure.rb"
load "Ecran_libre.rb"
load "Ecran_menu.rb"
load "Tuto.rb"
load "Utils.rb"


##
# Création de la fenetre
win = Gtk::Window.new()
win.set_title("FILL A PIX")

win.set_default_size(1200, 675)

win.set_resizable(false)

win.signal_connect('destroy'){
    Gtk.main_quit
    begin
        exit!
    rescue SystemExit
    end
}

Ecran_menu.creer(win)