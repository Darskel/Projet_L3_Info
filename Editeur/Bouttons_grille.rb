##
# La classe représente un bouton dans la grille du jeu
##
# * +couleur+   la couleur actuellement appliquée au bouton
# * +boutton+   Instance de la classe Gtk::Button
class Boutton_grille

    ##
    # * +css+   Le css a appliquer sur le boutton à l'init
    def Boutton_grille.creer(css)
        new(css)
    end

    private_class_method

    attr_reader :boutton
    attr_reader :css

    ##
    # * +css+   Le css a appliquer sur le boutton à l'init
    def initialize(css)
        @css = css
        @boutton = Gtk::Button.new(:label => " ")
        @boutton.style_context.add_provider(css, Gtk::StyleProvider::PRIORITY_USER)
    end

    ##
    # Permet de changer la couleur de fond et de police du boutton
    ##
    # * +cssW+  css pour la couleur blanc
    # * +cssB+  css pour la couleur noir
    # * +cssG+  css pour la couleur grey
    def change_etat(textBox, bEtat)
        @boutton.set_label(textBox.text)
        @boutton.style_context.add_provider(bEtat.css, Gtk::StyleProvider::PRIORITY_USER)
        @css = bEtat.css
        return self
    end

    ##
    # Créer le signal pour les interactions du bouton
    ##
    # * +cssW+  css pour la couleur blanc
    # * +cssB+  css pour la couleur noir
    # * +cssG+  css pour la couleur grey
    def signal(textBox, bEtat)
        @boutton.signal_connect("clicked"){ |o|
            change_etat(textBox, bEtat)
        }
        return self
    end
end