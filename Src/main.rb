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
load "Connexion.rb"
load "chronometre.rb"

$userPath = "../Users/"

##
# Création de la fenetre
win = Gtk::Window.new()

win.set_resizable(false)

win.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)

win.signal_connect('destroy'){
    Gtk.main_quit
    begin
        exit!
    rescue SystemExit
    end
}
Connexion.creer(win)