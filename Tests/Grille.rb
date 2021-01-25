load "css.rb"
load "Bouttons_grille.rb"

##
# Représentation d'une grille de jeu
##
# * +grille+    Une Gtk::Grid qui représente le plateau de jeu
# * +bouttons+  Tableau de boutons dans la grille
# * +css+       Les différents CSS utilisables
class Grille_jeu

    attr_reader :grille

    def initialize()
        @grille = Gtk::Grid.new()
        @grille.set_vexpand(true) #étend la grille pour occuper la place disponible
        @bouttons = Array.new(100)

        @css = Css.new()

        @grille.set_row_homogeneous(true)
        @grille.set_column_homogeneous(true)

        i = 0
        j = 0
        k = 0

        # création des boutons, connection des signaux et placement sur la grille
        while i < 100 do
            @bouttons[i] = Boutton_grille.creer(@css.cssW)
            @bouttons[i].signal(@css.cssW, @css.cssB, @css.cssG)

            @grille.attach(@bouttons[i].boutton,k , j, 1, 1)
            k +=1
            if k == 10
                k = 0
                j +=1
            end
            i += 1
        end
    end
end