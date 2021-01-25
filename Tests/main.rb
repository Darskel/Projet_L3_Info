require 'gtk3'

Gtk.init

load "Ecran_jeu.rb"

##
# Création de la fenetre
win = Gtk::Window.new()
win.set_title("FILL A PIX")
#win.maximize
win.fullscreen
#win.set_default_size(600, 400)


Ecran = Ecran_jeu.new()

boite = Ecran.boite

win.add(boite)

win.signal_connect('destroy'){
    Gtk.main_quit
}

win.show_all

Gtk.main