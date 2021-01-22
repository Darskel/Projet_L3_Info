
class Css
    def initialize()
        @cssW = Gtk::CssProvider.new
        @cssB = Gtk::CssProvider.new
        @cssG = Gtk::CssProvider.new


        @cssW.load(data: <<-CSS)
        button {
        background-image: image(white);
        color : black;
        }
        CSS


        @cssB.load(data: <<-CSS)
        button {
        background-image: image(black);
        color : white;
        }
        CSS

        @cssG.load(data: <<-CSS)
        button {
        background-image: image(grey);
        color : white;
        }
        CSS
    end

    attr_reader :cssG, :cssB, :cssW
end