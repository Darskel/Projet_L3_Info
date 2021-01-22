class Boutton_grille

    def Boutton_grille.creer(css)
        new(css)
    end

    private_class_method

    attr_reader :boutton, :couleur
    attr_reader :couleur

    def initialize(css)
        @couleur = "white"
        @boutton = Gtk::Button.new(:label => " ")
        @boutton.style_context.add_provider(css, Gtk::StyleProvider::PRIORITY_USER)
    end

    def change_couleur(cssW, cssB, cssG)
        if @couleur == "white"
            @boutton.style_context.add_provider(cssB, Gtk::StyleProvider::PRIORITY_USER)
            @couleur = "black"
        elsif @couleur == "black"
            @boutton.style_context.add_provider(cssG, Gtk::StyleProvider::PRIORITY_USER)
            @couleur = "grey"
        else
            @boutton.set_label("X")
            @boutton.style_context.add_provider(cssW, Gtk::StyleProvider::PRIORITY_USER)
            @couleur = "white"
        end
    end


end