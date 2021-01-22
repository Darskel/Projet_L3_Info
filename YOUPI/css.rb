##
# Classe représentant les différents css possibles
class Css
    def initialize()
        @cssW = Gtk::CssProvider.new
        @cssB = Gtk::CssProvider.new
        @cssG = Gtk::CssProvider.new

        # Css pour le fond blanc et la couleur de police noir
        @cssW.load(data: <<-CSS)
        button {
        background-image: image(white);
        color : black;
        }
        CSS

        # Css pour le fond noir et la couleur de police blanc
        @cssB.load(data: <<-CSS)
        button {
        background-image: image(black);
        color : white;
        }
        CSS

        # Css pour le fond gris et la couleur de police blanc
        @cssG.load(data: <<-CSS)
        button {
        background-image: image(grey);
        color : white;
        }
        CSS
    end

    attr_reader :cssG, :cssB, :cssW
end