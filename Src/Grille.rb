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

    def Grille_jeu.creer(joues)
        new(joues)
    end

    private_class_method :new

    ##
    # Création de la grille
    def initialize(joues)
        @grille = Gtk::Grid.new()
        @bouttons = Array.new(25, Array.new)
        @joues = joues

        @css = Css.new()

        charger("grille1.txt")
    end

    ##
    # Charge la grille spécifiée en paramètre
    ##
    # * +nom_grille+    Le nom du fichier a charger
    def charger(nom_grille)
        file = File.open(nom_grille)
        file_data = file.readlines.map(&:chomp)
        ligne_grille = file_data[1]
        ligne_solution = file_data[2]
        @nbLignes = file_data[0].split(' ')[0].to_i
        @nbColonnes = file_data[0].split(' ')[1].to_i
        file.close

        i_bouton = 0
        0.upto(@nbLignes-1) do |i|
            0.upto(@nbColonnes-1) do |j|
                # création des boutons, connection des signaux et placement sur la grille
                @bouttons[i][j] = Boutton_grille.creer(ligne_grille[i_bouton], @css.cssW, @joues, i, j)
                i_bouton += 1
                @bouttons[i][j].signal(@css.cssW, @css.cssB, @css.cssG)

                @grille.attach(@bouttons[i][j].boutton, j, i, 1, 1)
            end
        end
        
    end

    ##
    # Remet la couleur du bouton après un undo
    ##
    # * +coup+  le coup a restitué
    def revert(coup)
        print(coup)
        #sleep(100)
        @bouttons[coup.indiceI][coup.indiceJ].couleur= coup.couleur
        @bouttons[coup.indiceI][coup.indiceJ].updateCouleur
        ################# CRASH ICI
        return self
    end
end