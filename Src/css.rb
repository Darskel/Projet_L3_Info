##
# Classe représentant les différents css possibles
class Css

    ##
    # Création des différents css pour les boutons de la grille
    def initialize()
        @cssW = Gtk::CssProvider.new
        @cssB = Gtk::CssProvider.new
        @cssG = Gtk::CssProvider.new
        @cssWRedBorder = Gtk::CssProvider.new
        @cssBRedBorder = Gtk::CssProvider.new
        @cssGRedBorder = Gtk::CssProvider.new
        @falseReponse = Gtk::CssProvider.new

        # Css pour le fond blanc et la couleur de police noir
        @cssW.load(data: <<-CSS)
        button {
            background-image: image(white);
            color : black;
            border: 1px solid black;
            border-radius: 0px;
            box-shadow: 0 0 0 0px white inset;
        }
        CSS

        # Css pour le fond noir et la couleur de police blanc
        @cssB.load(data: <<-CSS)
        button {
            background-image: image(black);
            color : white;
            border: 1px solid white;
            border-radius: 0px;
            box-shadow: 0 0 0 0px black inset;
        }
        CSS

        # Css pour le fond gris et la couleur de police blanc
        @cssG.load(data: <<-CSS)
        button {
            background-image: image(grey);
            color : white;
            border: 1px solid white;
            border-radius: 0px;
            box-shadow: 0 0 0 0px grey inset;
        }
        CSS

        # Css pour le fond gris et la couleur de police blanc
        @falseReponse.load(data: <<-CSS)
        button {
            border: 1px groove red;
            box-shadow: 0 0 0 3px red inset;
        }
        CSS

        @cssWRedBorder.load(data: <<-CSS)
        button {
            background-image: image(white);
            color : black;
            border: 1px solid red;
            border-radius: 0px;
            box-shadow: 0 0 0 0px white inset;
        }
        CSS

        @cssBRedBorder.load(data: <<-CSS)
        button {
            background-image: image(black);
            color : white;
            border: 1px solid red;
            border-radius: 0px;
            box-shadow: 0 0 0 0px black inset;
        }
        CSS

        @cssGRedBorder.load(data: <<-CSS)
        button {
            background-image: image(grey);
            color : white;
            border: 1px solid red;
            border-radius: 0px;
            box-shadow: 0 0 0 0px grey inset;
        }
        CSS


    end

    attr_reader :cssG, :cssB, :cssW, :cssBRedBorder, :cssWRedBorder, :cssGRedBorder, :falseReponse
end