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
        @boite = Gtk::Box.new(:vertical, 5)

        @grille = Grille_jeu.new()

        @quit = Gtk::Button.new(:label => "Quitter")

        @boite.add(@grille.grille)
        @boite.add(@quit)

        @quit.signal_connect("clicked"){
            vers_menu()
        }

        @win.add(@boite)

        @win.show_all
    end

    ##
    # Permet de passer à l'écran du menu
    def vers_menu()
        @win.remove(@boite)
        @ecr  = Ecran_menu.creer(@win)
    end
end