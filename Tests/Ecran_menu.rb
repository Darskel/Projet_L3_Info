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

        @jouer = Gtk::Button.new(:label => "")
        @tuto = Gtk::Button.new(:label => "")
        @option = Gtk::Button.new(:label => "")
        @quitter = Gtk::Button.new(:label => "")

        @boite.add(Gtk::Image.new(:file => "../maquettes/menu.png"))
        @boite1.add(@boite)

        ##
        # Ajout des signaux des boutons
        @quitter.signal_connect("clicked"){
            @win.destroy
            Gtk.main_quit
            begin
                exit!
            rescue SystemExit
            end
        }
        @jouer.signal_connect("clicked"){
            vers_jeu()
        }

        ##
        # Création des CSS pour les boutons 
        jouerImage = Gtk::CssProvider.new

        jouerImage.load(data: <<-CSS)
        button {
            background-image: url("../maquettes/image18-3.png");
            border: unset;
        }
        CSS

        tutoImage = Gtk::CssProvider.new

        tutoImage.load(data: <<-CSS)
        button {
            background-image: url("../maquettes/image18-5.png");
            border: unset;
        }
        CSS

        optionImage = Gtk::CssProvider.new

        optionImage.load(data: <<-CSS)
        button {
            background-image: url("../maquettes/image18.png");
            border: unset;
        }
        CSS

        quitterImage = Gtk::CssProvider.new

        quitterImage.load(data: <<-CSS)
        button {
            background-image: url("../maquettes/quitter.png");
            border: unset;
        }
        CSS

        widthOptionsPrincipales = 1134
        heightOptionsPrincipales = 215
        width = 438
        height = 101

        ##
        # Ajout du CSS aux bouton et on leur donne leur taille
        @jouer.style_context.add_provider(jouerImage, Gtk::StyleProvider::PRIORITY_USER)
        @jouer.set_size_request(widthOptionsPrincipales, heightOptionsPrincipales)

        @option.style_context.add_provider(optionImage, Gtk::StyleProvider::PRIORITY_USER)  
        @option.set_size_request(widthOptionsPrincipales, heightOptionsPrincipales) 

        @tuto.style_context.add_provider(tutoImage, Gtk::StyleProvider::PRIORITY_USER)  
        @tuto.set_size_request(widthOptionsPrincipales, heightOptionsPrincipales) 

        @quitter.style_context.add_provider(quitterImage, Gtk::StyleProvider::PRIORITY_USER)  
        @quitter.set_size_request(width, height) 

        screen = @win.screen()

        ##
        #Ajout des boutons et box dans les containers
        #@boite.put(@jouer, ((Gdk::Screen.default.width) *0.4 - widthOptionsPrincipales), 300)
        @boite.put(@jouer, (screen.width() *0.4 - widthOptionsPrincipales), 300)
        @boite.put(@tuto, ((Gdk::Screen.default.width) *0.4 - widthOptionsPrincipales), 500)
        @boite.put(@option, ((Gdk::Screen.default.width) *0.4 - widthOptionsPrincipales), 700)
        @boite.put(@quitter, (Gdk::Screen.default.width * 0.67- widthOptionsPrincipales) , Gdk::Screen.default.height * 0.88)

        @win.add(@boite1)

        @win.show_all
        Gtk.main
    end

    ##
    # Permet de changer la fenetre pour aller afficher l'écran de jeu
    def vers_jeu()
        @win.remove(@boite1)
        @ecr = Ecran_jeu.creer(@win)
    end
end