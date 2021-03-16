##
# La classe représente un bouton dans la grille du jeu
##
# * +couleur+   la couleur actuellement appliquée au bouton
# * +boutton+   Instance de la classe Gtk::Button
class Boutton

    ##
    # * +css+   Le css a appliquer sur le boutton à l'init
    def Boutton.creer(css)
        new(css)
    end

    private_class_method

    attr_reader :boutton
    attr_reader :css

    ##
    # * +css+   Le css a appliquer sur le boutton à l'init
    def initialize(css)
        @couleur = "white"
        @boutton = Gtk::Button.new(:label => " ")
        @css = css
        @boutton.style_context.add_provider(css, Gtk::StyleProvider::PRIORITY_USER)
    end

    ##
    # Permet de changer la couleur de fond et de police du boutton
    ##
    # * +cssW+  css pour la couleur blanc
    # * +cssB+  css pour la couleur noir
    # * +cssG+  css pour la couleur grey
    def change_couleur(cssW, cssB)
        if @couleur == "white"
            @css = cssB
            @couleur = "black"
        elsif @couleur == "black"
            @css = cssW
            @couleur = "white"
        end

        @boutton.style_context.add_provider(@css, Gtk::StyleProvider::PRIORITY_USER)

    
        return self
    end

    ##
    # Créer le signal pour les interactions du bouton
    ##
    # * +cssW+  css pour la couleur blanc
    # * +cssB+  css pour la couleur noir
    # * +cssG+  css pour la couleur grey
    def signal(cssW, cssB)
        @boutton.signal_connect("clicked"){ |o|
            change_couleur(cssW, cssB)
        }
        return self
    end

end