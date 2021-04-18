require 'gtk3'

Gtk.init

load "Ecran_jeu.rb"
load "EcranJouer.rb"
load "EcranOptions.rb"
load "Ecran_aventure.rb"
load "Ecran_progression.rb"
load "Ecran_libre.rb"
load "Ecran_menu.rb"
load "Credit.rb"
load "Tuto.rb"
load "Utils.rb"
load "Connexion.rb"
load "chronometre.rb"
load "Classement.rb"
load "Succes.rb"

$userPath = "../Users/"
$widthEcran = 1200
$heightEcran = 675

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