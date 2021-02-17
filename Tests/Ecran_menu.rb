class Ecran_menu

    def Ecran_menu.creer(win)
        new(win)
    end

    private_class_method :new

    ##
    #
    ##
    # * +win+   La fenetre de l'application
    def initialize(win)
        @win = win
        @boite = Gtk::Fixed.new()
        @boite1 = Gtk::Box.new(:vertical)

        @jouer = Gtk::Button.new(:label => "Jouer")
        @quitter = Gtk::Button.new(:label => "Quitter")

        @boite.add(Gtk::Image.new("../maquettes/menu.png"))
        @boite1.add(@boite)

        @quitter.signal_connect("clicked"){
            Gtk.main_quit
        }
        @jouer.signal_connect("clicked"){
            vers_jeu()
        }

        truc = Gtk::CssProvider.new

        truc.load(data: <<-CSS)
        button {
            background-image: image(white);
            color: black;
        }
        CSS

        @jouer.style_context.add_provider(truc, Gtk::StyleProvider::PRIORITY_USER)
        @quitter.style_context.add_provider(truc, Gtk::StyleProvider::PRIORITY_USER)   

        #@boite.put(@jouer, 500, 500)

        @win.add(@boite1)

        @win.show_all
        Gtk.main
    end

    ##
    # Permet de changer la fenetre pour aller afficher l'écran de jeu
    def vers_jeu()
        @win.remove(@boite)
        Ecran_jeu.creer(@win)
    end
end