load "css.rb"
load "Bouttons_grille.rb"

##
# Représentation d'une grille de jeu
##
# * +grille+    Une Gtk::Grid qui représente le plateau de jeu
# * +bouttons+  Tableau de boutons dans la grille
# * +css+       Les différents CSS utilisables
# * +joues+     Tableau des coups joués par l'utilisateur, permettant l'utilisationd de la fonctionnalité undo
class Grille_jeu

    attr_reader :grille

    def Grille_jeu.creer(estJouable, joues)
        new(estJouable, joues)
    end

    private_class_method :new

    ##
    # Création de la grille
    def initialize(estJouable, joues)
        @grille = Gtk::Grid.new()
        @bouttons = Array.new(25)
        0.upto(25) do |i|
            @bouttons[i] = Array.new(25)
        end
        @joues = joues

        @css = Css.new()

        charger("grille1.txt")

        unless (estJouable)
            rendreNonJouable()
        end
    end

    def rendreNonJouable()
        0.upto(@nbLignes-1) do |i|
            0.upto(@nbColonnes-1) do |j|
                #Rend le bouton non cliquable
                @bouttons[i][j].boutton.sensitive = false
            end
        end
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
        return self
    end

    ##
    # Remet la couleur du bouton après un undo
    ##
    # * +coup+  le coup a restitué
    def undo(coup)
        @bouttons[coup.indiceI][coup.indiceJ].couleur= coup.couleur
        @bouttons[coup.indiceI][coup.indiceJ].updateCouleur(@css.cssW, @css.cssB, @css.cssG)
        return self
    end

    ##
    # Vérification de la grille demandée par l'utilisateur
    def check()
        file = File.open("grille1.txt")
        file_data = file.readlines.map(&:chomp)
            
        ligne_solution = file_data[2]

        file.close

        succes = true

        0.upto(@nbLignes-1) do |i|
            0.upto(@nbColonnes-1) do |j|

                if@bouttons[i][j].couleur == "grey" && ligne_solution[i * @nbLignes + j].to_i == 1
                    succes = false
                    @bouttons[i][j].mauvaiseReponse(@css.falseReponse)
                end
                if @bouttons[i][j].couleur == "black" && ligne_solution[i * @nbLignes + j].to_i == 0
                    succes = false
                    @bouttons[i][j].mauvaiseReponse(@css.falseReponse)
                end
            end
        end
        return succes
    end
end