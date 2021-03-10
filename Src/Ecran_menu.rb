
##
# Classe qui permet d'accèder au menu principal
##
# * +win+   La fenetre de l'application
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
            opacity: 0;
            border: unset;
        }
        CSS

        tutoImage = Gtk::CssProvider.new

        tutoImage.load(data: <<-CSS)
        button {
            opacity: 0;
            border: unset;
        }
        CSS

        optionImage = Gtk::CssProvider.new

        optionImage.load(data: <<-CSS)
        button {
            opacity: 0;
            border: unset;
        }
        CSS

        quitterImage = Gtk::CssProvider.new

        quitterImage.load(data: <<-CSS)
        button {
            opacity: 0;
            border: unset;
        }
        CSS

        screen = @win.screen()

        widthOptionsPrincipales = 500
        heightOptionsPrincipales = 100
        width = 280
        height = 57

        ##
        # Ajout du CSS aux bouton et on leur donne leur taille
        @jouer.style_context.add_provider(jouerImage, Gtk::StyleProvider::PRIORITY_USER)
        @jouer.set_size_request(widthOptionsPrincipales, heightOptionsPrincipales)

        @option.style_context.add_provider(optionImage, Gtk::StyleProvider::PRIORITY_USER)  
        @option.set_size_request(widthOptionsPrincipales*1.3, heightOptionsPrincipales) 

        @tuto.style_context.add_provider(tutoImage, Gtk::StyleProvider::PRIORITY_USER)  
        @tuto.set_size_request(widthOptionsPrincipales * 1.37, heightOptionsPrincipales * 1.05) 

        @quitter.style_context.add_provider(quitterImage, Gtk::StyleProvider::PRIORITY_USER)  
        @quitter.set_size_request(width, height) 

        ##
        #Ajout des boutons et box dans les containers
        @boite.put(@jouer, (1200 *0.243), 675 * 0.34)
        @boite.put(@tuto, (1200 *0.15), 675 * 0.52)
        @boite.put(@option, (1200 *0.18), 675 * 0.71)
        @boite.put(@quitter, (1200 *0.75) , 675 * 0.89)

        @win.add(@boite1)

        @win.show_all
        Gtk.main
    end

    ##
    # Permet de changer la fenetre pour aller afficher l'écran de jeu
    def vers_jeu()
        @win.remove(@boite1)
        @ecr = EcranJouer.creer(@win)
    end
end