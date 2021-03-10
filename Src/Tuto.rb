load "Grille.rb"
load "Utils.rb"
class Tuto

    private_class_method :new

    def Tuto.creer(win)
        new(win)
    end

    def initialize(win)
        @window = win

        @box = Gtk::Fixed.new()
        @box2 = Gtk::Box.new(:horizontal)

        @suivant = Gtk::Button.new(:label => "Règle suivante")
        @retourMenu = Gtk::Button.new()
        @boutonBack = Gtk::Button.new()
        @boutonOptions = Gtk::Button.new()

        retourMenucss = Gtk::CssProvider.new()

        retourMenucss.load(data: <<-CSS)
        button {
            opacity: 0;
            border: unset;
        }
        CSS

        @retourMenu.style_context.add_provider(retourMenucss, Gtk::StyleProvider::PRIORITY_USER)
        @retourMenu.set_size_request(55, 45)
        @retourMenu.signal_connect("clicked"){
            Utils.vers_menu(@window)
        }
        #@boutonBack.set_size_request(widthOptionsPrincipales, heightOptionsPrincipales) 
        #@boutonOptions.set_size_request(widthOptionsPrincipales, heightOptionsPrincipales) 

        @box.add(Gtk::Image.new(:file => "../maquettes/TutorielV2.png"))
        @box2.add(@box)

        @box.put(@retourMenu,(1200 *0.015), 675 * 0.025)
        @box.put(@suivant,(1200 *0.85), 675 * 0.5)
        @box.put(@boutonBack, 1200*0.8, 675*0)
        @box.put(@boutonOptions,1200*0.95, 675*0.03)
        
        @window.add(@box2)
        @window.show_all
    end
end

#gtkbox horizontal avec text gauche + grille + text droit 