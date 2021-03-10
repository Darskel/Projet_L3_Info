
##
#
##
# * +win+   La fenetre de l'application
class EcranJouer
    

    def EcranJouer.creer(win)
        new(win)
    end

    private_class_method :new

    ##
    # Placement et chargement des objets de l'écran, connection des signaux
    ##
    # * +win+   La fenetre de l'application
    def initialize(win)
        @win = win

        @boite = Gtk::Fixed.new()
        @layoutManager = Gtk::Box.new(:vertical)

        @aventure = Gtk::Button.new(:label => "")
        @libre = Gtk::Button.new(:label => "")
        @fermer = Gtk::Button.new(:label => "")

        @boite.add(Gtk::Image.new(:file => "../maquettes/menu_jouer.png"))
        @layoutManager.add(@boite)

        ##
        # Ajout des signaux des boutons
        @fermer.signal_connect("clicked"){
            vers_menu()
        }
        @aventure.signal_connect("clicked"){
            vers_jeu()
        }

        ##
        # Création des CSS pour les boutons 
        aventureImage = Gtk::CssProvider.new

        aventureImage.load(data: <<-CSS)
        button {
            opacity: 0;
            border: unset;
        }
        CSS

        libreImage = Gtk::CssProvider.new

        libreImage.load(data: <<-CSS)
        button {
            opacity: 0;
            border: unset;
        }
        CSS

        fermerImage = Gtk::CssProvider.new

        fermerImage.load(data: <<-CSS)
        button {
            opacity: 0;
            border: unset;
        }
        CSS

        screen = @win.screen()

        widthOptionsPrincipales = 307
        heightOptionsPrincipales = 68
        width = 31
        height = 19

        ##
        # Ajout du CSS aux bouton et on leur donne leur taille
        @aventure.style_context.add_provider(aventureImage, Gtk::StyleProvider::PRIORITY_USER)
        @aventure.set_size_request(widthOptionsPrincipales, heightOptionsPrincipales)

        @libre.style_context.add_provider(libreImage, Gtk::StyleProvider::PRIORITY_USER)
        @libre.set_size_request(widthOptionsPrincipales, heightOptionsPrincipales)
        
        @fermer.style_context.add_provider(fermerImage, Gtk::StyleProvider::PRIORITY_USER)
        @fermer.set_size_request(width, height)

        ##
        #Ajout des boutons et box dans les containers
        @boite.put(@aventure, (1200 *0.355), 675 * 0.53)
        @boite.put(@libre, (1200 *0.355), 675 * 0.7)
        @boite.put(@fermer, (1200 *0.63), 675 * 0.24)

        @win.add(@layoutManager)

        @win.show_all
    end

    ##
    # Permet de changer la fenetre pour aller afficher l'écran de jeu
    def vers_jeu()
        @win.remove(@layoutManager)
        @ecr = Ecran_aventure.creer(@win)
    end

    ##
    # Permet de changer la fenetre pour aller afficher l'écran de jeu
    def vers_menu()
        @win.remove(@layoutManager)
        @ecr = Ecran_menu.creer(@win)
    end
end