load "Grille.rb"

##
# Représentation d'un écran de jeu, une partie de fill a pix
##
# * +boite+     Gtk::box qui contiendra le plateau de jeu et les différents boutons
# * +grille+    Une instance de la classe Grille_jeu représentant le plateau de jeu
# * +quit+      Gtk::Button qui permet de fermer le jeu
class Ecran_jeu

    attr_reader :boite

    def initialize()
        @boite = Gtk::Box.new(:vertical, 5)

        @grille = Grille_jeu.new()

        @quit = Gtk::Button.new(:label => "Quitter")

        @boite.add(@grille.grille)
        @boite.add(@quit)

        @quit.signal_connect("clicked"){
            Gtk.main_quit
        }
    end
end