load "coup_joue.rb"

##
# La classe représente un bouton dans la grille du jeu
##
# * +couleur+   la couleur actuellement appliquée au bouton
# * +boutton+   Instance de la classe Gtk::Button
# * +indiceI+   Indice du bouton en x
# * +indiceJ+   Indice du bouton en y
# * +joues+     Tableau des coups joués
class Boutton_grille

    ##
    # Constructeur de la classe
    ##
    # * +css+       Le css a appliquer sur le boutton à l'init
    # * +indiceI+   Indice du bouton en x
    # * +indiceJ+   Indice du bouton en y
    # * +joues+     Tableau des coups joués
    # * +contenu+   Texte du bouton
    def Boutton_grille.creer(contenu, css, joues, indiceI, indiceJ, grille)
        new(contenu, css, joues, indiceI, indiceJ, grille)
    end

    private_class_method

    attr_reader :boutton
    attr_accessor :couleur, :contenu, :boutton

    ##
    # Initialisation de l'instance
    ##
    # * +css+       Le css a appliquer sur le boutton à l'init
    # * +indiceI+   Indice du bouton en x
    # * +indiceJ+   Indice du bouton en y
    # * +joues+     Tableau des coups joués
    # * +contenu+   Texte du bouton
    def initialize(contenu, css, joues, indiceI, indiceJ, grille)
        @contenu = contenu
        @couleur = "white"
        @boutton = Gtk::Button.new(:label => contenu)
        @boutton.style_context.add_provider(css, Gtk::StyleProvider::PRIORITY_USER)
        @boutton.set_size_request(5, 5) 
        @joues, @indiceI, @indiceJ = joues, indiceI, indiceJ
        @grille = grille
    end

    ##
    # Permet de changer la couleur de fond et de police du boutton
    ##
    # * +cssW+  css pour la couleur blanc
    # * +cssB+  css pour la couleur noir
    # * +cssG+  css pour la couleur grey
    def change_couleur(cssW, cssB, cssG)
        if @couleur == "white"
            @boutton.style_context.add_provider(cssB, Gtk::StyleProvider::PRIORITY_USER)
            @couleur = "black"
        elsif @couleur == "black"
            @boutton.style_context.add_provider(cssG, Gtk::StyleProvider::PRIORITY_USER)
            @couleur = "grey"
        else
            @boutton.style_context.add_provider(cssW, Gtk::StyleProvider::PRIORITY_USER)
            @couleur = "white"
        end
        return self
    end

    ##
    # Applique une bordure rouge sur le bouton pour symboliser une mauvaise réponse
    ##
    # * +falseReponse+  le CSS a appliquer sur le bouton
    def mauvaiseReponse(falseReponse)
        @boutton.style_context.add_provider(falseReponse, Gtk::StyleProvider::PRIORITY_USER)
        return self
    end

    ##
    # met a jour la couleur du bouton après un undo
    ##
    # * +cssW+  css pour la couleur blanc
    # * +cssB+  css pour la couleur noir
    # * +cssG+  css pour la couleur grey
    def updateCouleur(cssW, cssB, cssG)
        if @couleur == "white"
            @boutton.style_context.add_provider(cssW, Gtk::StyleProvider::PRIORITY_USER)
        elsif @couleur == "black"
            @boutton.style_context.add_provider(cssB, Gtk::StyleProvider::PRIORITY_USER)
        else
            @boutton.style_context.add_provider(cssG, Gtk::StyleProvider::PRIORITY_USER)
        end
        return self
    end

    
    ##
    # Créer le signal pour les interactions du bouton
    ##
    # * +cssW+  css pour la couleur blanc
    # * +cssB+  css pour la couleur noir
    # * +cssG+  css pour la couleur grey
    def signal(cssW, cssB, cssG)
        @boutton.signal_connect("clicked"){ |o|
            @joues.push(Coup_joue.creer(@indiceI, @indiceJ, @couleur))
            change_couleur(cssW, cssB, cssG)
        }
        @boutton.signal_connect("enter"){ |o|
            @grille.enterButton(@indiceI, @indiceJ);
        }
        @boutton.signal_connect("leave"){ |o|
            @grille.leaveButton(@indiceI, @indiceJ);
        }
        return self
    end
end