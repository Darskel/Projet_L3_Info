load "Grille.rb"
load "Utils.rb"
class Tuto

    private_class_method :new

    def Tuto.creer(win)
        new(win)
    end

    def initialize(win)
        #Création de l'interface 
        @window = win
        @box = Gtk::Fixed.new()
        @box2 = Gtk::Box.new(:horizontal)
        @suivant = Gtk::Button.new(:label => "Règle suivante")
        @retourMenu = Gtk::Button.new()
        @boutonBack = Gtk::Button.new()
        @boutonOptions = Gtk::Button.new()

        #Css des boutons pour les rendres invisibles
        retourMenucss = Gtk::CssProvider.new()
        backCss = Gtk::CssProvider.new()
        optionsCss = Gtk::CssProvider.new()
        retourMenucss.load(data: <<-CSS)
        button {
            opacity: 0;
            border: unset;
        }
        CSS
        optionsCss.load(data: <<-CSS)
        button {
            opacity: 0;
            border: unset;
        }
        CSS
        backCss.load(data: <<-CSS)
        button {
            opacity: 0;
            border: unset;
        }
        CSS

        @retourMenu.style_context.add_provider(retourMenucss, Gtk::StyleProvider::PRIORITY_USER)
        @retourMenu.set_size_request(55, 45)
        @retourMenu.signal_connect("clicked"){
            vers_menu(@window,@box2)
        }
        
        @boutonOptions.style_context.add_provider(optionsCss, Gtk::StyleProvider::PRIORITY_USER)
        @boutonOptions.set_size_request(60, 60)
        @boutonOptions.signal_connect("clicked"){
            #FonctionQuiOuvreLesOptions
        }

        @boutonBack.style_context.add_provider(backCss, Gtk::StyleProvider::PRIORITY_USER)
        @boutonBack.set_size_request(60, 60)
        @boutonBack.signal_connect("clicked"){
            #FonctionQuifaitLeRetourArriere
        }

        @box.add(Gtk::Image.new(:file => "../maquettes/TutorielV2.png"))
        @box2.add(@box)

        @box.put(@retourMenu,(1200 *0.015), 675 * 0.025)
        @box.put(@suivant,(1200 *0.85), 675 * 0.5)
        @box.put(@boutonOptions, 1200*0.94, 675*0.02)
        @box.put(@boutonBack,1200*0.89, 675*0.02)
        
        @window.add(@box2)
        @window.show_all
    end
end

#gtkbox horizontal avec text gauche + grille + text droit 