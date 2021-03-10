##
# La classe représente un bouton dans la grille du jeu
##
# * +couleur+   la couleur actuellement appliquée au bouton
# * +boutton+   Instance de la classe Gtk::Button
class Boutton_grille

    ##
    # * +css+   Le css a appliquer sur le boutton à l'init
    def Boutton_grille.creer(contenu, css)
        new(contenu, css)
    end

    private_class_method

    attr_reader :boutton

    ##
    # * +css+   Le css a appliquer sur le boutton à l'init
    def initialize(contenu, css)
        @couleur = "white"
        @boutton = Gtk::Button.new(:label => contenu)
        @boutton.style_context.add_provider(css, Gtk::StyleProvider::PRIORITY_USER)
        @boutton.set_size_request(5, 5) 
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
    # Créer le signal pour les interactions du bouton
    ##
    # * +cssW+  css pour la couleur blanc
    # * +cssB+  css pour la couleur noir
    # * +cssG+  css pour la couleur grey
    def signal(cssW, cssB, cssG)
        @boutton.signal_connect("clicked"){ |o|
            change_couleur(cssW, cssB, cssG)
        }
        return self
    end
end