require 'gtk3'

Gtk.init

load "css.rb"
load "Bouttons_grille.rb"

css = Css.new()

win = Gtk::Window.new()
win.set_default_size(400, 400)
win.set_title("FILL A PIX")

boite = Gtk::Box.new(:horizontal, 5)
grille = Gtk::Grid.new()

win.add(boite)

bouttons = Array.new(100)

boite.add(grille)

grille.set_row_homogeneous(true)
grille.set_column_homogeneous(true)

i = 0
j = 0
k = 0

# création des boutons, connection des signaux et placement sur la grille
while i < 100 do
    bouttons[i] = Boutton_grille.creer(css.cssW)
    bouttons[i].signal(css.cssW, css.cssB, css.cssG)

    grille.attach(bouttons[i].boutton,k , j, 1, 1)
    k +=1
    if k == 10
        k = 0
        j +=1
    end
    i += 1
end




win.signal_connect('destroy'){
    Gtk.main_quit
}

win.show_all

Gtk.main