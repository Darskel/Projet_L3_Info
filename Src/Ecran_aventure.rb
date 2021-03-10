class Ecran_aventure
    

    def Ecran_aventure.creer(win)
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

        @fleche = Gtk::Button.new(:label => "")
        @demarrer = Gtk::Button.new(:label => "")
        @reprendre = Gtk::Button.new(:label => "")
        @progression = Gtk::Button.new(:label => "")
        @quitter = Gtk::Button.new(:label => "")

        @boite.add(Gtk::Image.new(:file => "../maquettes/menu-aventure.png"))
        @boite1.add(@boite)

        ##
        # Ajout des signaux des boutons
        @fleche.signal_connect("clicked"){
            vers_menu()
        }
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

        ##
        # Création des CSS pour les boutons 
        css = Gtk::CssProvider.new

        css.load(data: <<-CSS)
        button {
            opacity: 0;
            border: unset;
        }
        CSS
        
        screen = @win.screen()

        widthOptionsPrincipales = 500
        heightOptionsPrincipales = 100
        width = 150
        height = 50

        heightEcran = 675
        widhtEcran = 1200

        ##
        # Ajout du CSS aux bouton et on leur donne leur taille
        @fleche.style_context.add_provider(css, Gtk::StyleProvider::PRIORITY_USER)
        @fleche.set_size_request(100, 80)

        @demarrer.style_context.add_provider(css, Gtk::StyleProvider::PRIORITY_USER)
        @demarrer.set_size_request(500, 80)

        @reprendre.style_context.add_provider(css, Gtk::StyleProvider::PRIORITY_USER)   
        @reprendre.set_size_request(500, 80)

        @progression.style_context.add_provider(css, Gtk::StyleProvider::PRIORITY_USER)  
        @progression.set_size_request(600, 80)

        @quitter.style_context.add_provider(css, Gtk::StyleProvider::PRIORITY_USER)  
        @quitter.set_size_request(280, 60)

        ##
        #Ajout des boutons et box dans les containers
        @boite.put(@fleche, 20, 5)
        @boite.put(@demarrer, (widhtEcran *0.25), heightEcran * 0.5)
        @boite.put(@reprendre, (widhtEcran *0.25), heightEcran * 0.65)
        @boite.put(@progression, (widhtEcran *0.20), heightEcran * 0.8)
        @boite.put(@quitter, (widhtEcran *0.75) , heightEcran * 0.885)

        @win.add(@boite1)

        @win.show_all
        Gtk.main
    end

    ##
    # Permet de changer la fenetre pour aller afficher l'écran de jeu
    def vers_menu()
        @win.remove(@boite1)
        @ecr = Ecran_menu.creer(@win)
    end

end