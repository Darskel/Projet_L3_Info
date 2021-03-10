class Ecran_libre
    

    def Ecran_libre.creer(win)
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

        @boite.add(Gtk::Image.new(:file => "../maquettes/menu-libre.png"))
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

        ##
        # Création des CSS pour les boutons 
        flecheImage = Gtk::CssProvider.new

        flecheImage.load(data: <<-CSS)
        button {
            opacity: 0;
            border: unset;
        }
        CSS
        
        demarrerImage = Gtk::CssProvider.new

        demarrerImage.load(data: <<-CSS)
        button {
            opacity: 0;
            border: unset;
        }
        CSS

        reprendreImage = Gtk::CssProvider.new

        reprendreImage.load(data: <<-CSS)
        button {
            opacity: 0;
            border: unset;
        }
        CSS

        progressionImage = Gtk::CssProvider.new

        progressionImage.load(data: <<-CSS)
        button {
            /* opacity: 0;*/
            border: unset;
        }
        CSS

        quitterImage = Gtk::CssProvider.new

        quitterImage.load(data: <<-CSS)
        button {
            /* opacity: 0;*/
            border: unset;
        }
        CSS

        screen = @win.screen()

        widthOptionsPrincipales = 500
        heightOptionsPrincipales = 100
        width = 150
        height = 50

        widthEcran = 1200
        heightEcran = 675

        ##
        # Ajout du CSS aux bouton et on leur donne leur taille
        @fleche.style_context.add_provider(flecheImage, Gtk::StyleProvider::PRIORITY_USER)
        @fleche.set_size_request(100, 80)

        @demarrer.style_context.add_provider(demarrerImage, Gtk::StyleProvider::PRIORITY_USER)
        @demarrer.set_size_request(widthOptionsPrincipales, heightOptionsPrincipales)
        @demarrer.set_size_request(500, 80)

        @reprendre.style_context.add_provider(reprendreImage, Gtk::StyleProvider::PRIORITY_USER)  
        @reprendre.set_size_request(widthOptionsPrincipales, heightOptionsPrincipales) 
        @reprendre.set_size_request(500, 80)

        @progression.style_context.add_provider(progressionImage, Gtk::StyleProvider::PRIORITY_USER)  
        @progression.set_size_request(widthOptionsPrincipales, heightOptionsPrincipales) 
        @progression.set_size_request(550, 80)

        @quitter.style_context.add_provider(quitterImage, Gtk::StyleProvider::PRIORITY_USER)  
        @quitter.set_size_request(width, height) 

        ##
        #Ajout des boutons et box dans les containers
        @boite.put(@fleche, 20, 5)
        @boite.put(@demarrer, (widthEcran *0.25), heightEcran * 0.5)
        @boite.put(@reprendre, (widthEcran *0.25), heightEcran * 0.65)
        @boite.put(@progression, (widthEcran *0.20), heightEcran * 0.8)
        @boite.put(@quitter, (widthEcran *0.85) , heightEcran * 0.875)

        @win.add(@boite1)

        @win.show_all
        Gtk.main
    end

end