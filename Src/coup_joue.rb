##
# Classe permettant de sauvegarder un coup joué par l'utilisateur
##
# * +indiceI+    indice du bouton en x
# * +indiceJ+    indice du bouton en y
# * +couleur+   couleur a restituer
class Coup_joue

    ##
    # Constructeur
    ##
    # * +indiceI+   Indice du bouton en x
    # * +indiceJ+   Indice du bouton en y
    # * +couleur+   Couleur a restituer
    def Coup_joue.creer(indiceI, indiceJ, couleur)
        new(indiceI, indiceJ, couleur)
    end

    private_class_method :new

    ##
    # Initialisation de l'instance
    ##
    # * +indiceI+   Indice du bouton en x
    # * +indiceJ+   Indice du bouton en y
    # * +couleur+   Couleur a restituer
    def initialize(indiceI, indiceJ, couleur)
        @indiceI, @indiceJ, @couleur = indiceI, indiceJ, couleur
    end

    attr_reader :indiceI, :indiceJ, :couleur

    ##
    # redéfinition de l'affichage
    def to_s
        return @indiceI.to_s + " " + @indiceJ.to_s + " " + @couleur
    end
end