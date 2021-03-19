load "css.rb"
load "Bouttons_grille.rb"
load "Boutton.rb"

##
# Représentation d'une grille de jeu
##
# * +grille+    Une Gtk::Grid qui représente le plateau de jeu
# * +bouttons+  Tableau de boutons dans la grille
# * +css+       Les différents CSS utilisables
class Grille_jeu

    attr_reader :grille

    def initialize(nbLignes, nbColonnes)
        @grille = Gtk::Grid.new()
        @grille.set_vexpand(true) #étend la grille pour occuper la place disponible
        @bouttons = Array.new(100)

        @nbLignes = nbLignes
        @nbColonnes = nbColonnes

        @css = Css.new()

        @grille.set_row_homogeneous(true)
        @grille.set_column_homogeneous(true)

        i = 0
        j = 0
        k = 0

        @textBox = Gtk::Entry.new
        @bEtat = Boutton.creer(@css.cssW)

        # création des boutons, connection des signaux et placement sur la grille
        while j < nbLignes do
            k = 0
            while k < nbColonnes do
                @bouttons[i] = Boutton_grille.creer(@css.cssW)
                @bouttons[i].signal(@textBox, @bEtat)

                @grille.attach(@bouttons[i].boutton, k , j, 1, 1)
                k += 1
                i += 1
            end
            j += 1
        end
        @grille.attach(@textBox, 4, j, 2, 1)
        @bEtat.signal(@css.cssW, @css.cssB)
        @grille.attach(@bEtat.boutton, 6, j, 1, 1)

    end

    def save()
        nomFic = "../Grilles/" + @textBox.text + ".txt"
        File.open(nomFic, "w")

        nbBoutons = @nbLignes * @nbColonnes

        File.write(nomFic, @nbLignes.to_s + " " + @nbColonnes.to_s + "\n", mode: "a")

        i = 0
        while i < nbBoutons do
            File.write(nomFic, @bouttons[i].boutton.label, mode: "a")
            i += 1
        end
        File.write(nomFic, "\n", mode: "a")
        i = 0
        while i < nbBoutons do
            File.write(nomFic, (@bouttons[i].css == @css.cssW)? "0" : 1, mode: "a")
            i += 1
        end

    end
end