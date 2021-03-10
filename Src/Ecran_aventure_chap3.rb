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

        @boite.add(Gtk::Image.new(:file => "../maquettes/aventure_chap3.png"))
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
            background-image: url("../maquettes/fleche_retour.png");
            background-size: 100% 100%;
            border: unset;
        }
        CSS
        
        demarrerImage = Gtk::CssProvider.new

        demarrerImage.load(data: <<-CSS)
        button {
            background-image: url("../maquettes/image_demarrer.png");
            background-size: 100% 100%;
            border: unset;
        }
        CSS

        reprendreImage = Gtk::CssProvider.new

        reprendreImage.load(data: <<-CSS)
        button {
            background-image: url("../maquettes/image_reprendre.png");
            background-size: 100% 100%;
            border: unset;
        }
        CSS

        progressionImage = Gtk::CssProvider.new

        progressionImage.load(data: <<-CSS)
        button {
            background-image: url("../maquettes/image_progression.png");
            background-size: 100% 100%;
            border: unset;
        }
        CSS

        quitterImage = Gtk::CssProvider.new

        quitterImage.load(data: <<-CSS)
        button {
            background-image: url("../maquettes/quitter.png");
            background-size: 100% 100%;
            border: unset;
        }
        CSS

        screen = @win.screen()

        widthOptionsPrincipales = 500
        heightOptionsPrincipales = 100
        width = 150
        height = 50

        ##
        # Ajout du CSS aux bouton et on leur donne leur taille
        @fleche.style_context.add_provider(flecheImage, Gtk::StyleProvider::PRIORITY_USER)
        @fleche.set_size_request(100, 80)

        @demarrer.style_context.add_provider(demarrerImage, Gtk::StyleProvider::PRIORITY_USER)
        @demarrer.set_size_request(widthOptionsPrincipales, heightOptionsPrincipales)

        @reprendre.style_context.add_provider(reprendreImage, Gtk::StyleProvider::PRIORITY_USER)  
        @reprendre.set_size_request(widthOptionsPrincipales, heightOptionsPrincipales) 

        @progression.style_context.add_provider(progressionImage, Gtk::StyleProvider::PRIORITY_USER)  
        @progression.set_size_request(widthOptionsPrincipales, heightOptionsPrincipales) 

        @quitter.style_context.add_provider(quitterImage, Gtk::StyleProvider::PRIORITY_USER)  
        @quitter.set_size_request(width, height) 

        ##
        #Ajout des boutons et box dans les containers
        @boite.put(@fleche, 20, 5)
        @boite.put(@demarrer, (1200 *0.25), 675 * 0.5)
        @boite.put(@reprendre, (1200 *0.25), 675 * 0.7)
        @boite.put(@progression, (1200 *0.25), 675 * 0.9)
        @boite.put(@quitter, (1200 *0.85) , 675 * 0.875)

        @win.add(@boite1)

        @win.show_all
        Gtk.main
    end

end