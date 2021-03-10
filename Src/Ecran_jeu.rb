load "Grille.rb"

##
# Représentation d'un écran de jeu, une partie de fill a pix
##
# * +win+       La fenêtre graphique du programme
# * +boite+     Gtk::box qui contiendra le plateau de jeu et les différents boutons
# * +grille+    Une instance de la classe Grille_jeu représentant le plateau de jeu
# * +quit+      Gtk::Button qui permet de fermer le jeu
class Ecran_jeu

    def Ecran_jeu.creer(win)
        new(win)
    end
    private_class_method :new

    def initialize(win)
        @win = win

        @layoutManager = Gtk::Box.new(:vertical, 5)
        @espaceJeu = Gtk::Box.new(:horizontal, 5)

        @grille = Grille_jeu.new()
        @textfield1 = Gtk::Label.new("")
        @textfield2 = Gtk::Label.new("")
        @textfield1.set_size_request(350, 200) 

        @quit = Gtk::Button.new(:label => "Quitter")
        

        @quit.signal_connect("clicked"){
            vers_menu()
        }

        @espaceJeu.add(@textfield1)
        @espaceJeu.add(@grille.grille)
        @espaceJeu.add(@textfield2)

        #@espaceJeu.set_homogeneous true

        @layoutManager.add(@espaceJeu)
        @layoutManager.add(@quit)
        @win.add(@layoutManager)

        @win.show_all
    end

    ##
    # Permet de passer à l'écran du menu
    def vers_menu()
        @win.remove(@layoutManager)
        @ecr  = Ecran_menu.creer(@win)
    end
end