
##
# La classe qui gère l'affichage et l'interaction avec le menu qui permet de rejoindre l'aventure ou le mode libre
##
# * +win+   La fenetre de l'application
class EcranJouer
    

    ##
    # Constructeur de la classe
    ##
    # * +win+   La fenetre de l'application
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
        @libre.signal_connect("clicked"){
            vers_libre()
        }

        ##
        # Création des CSS pour les boutons 
        aventureImage = ajouteCss(2)
        libreImage = ajouteCss(2)
        fermerImage = ajouteCss(1)
        

        screen = @win.screen()

        widthOptionsPrincipales = 307
        heightOptionsPrincipales = 68
        width = 31
        height = 19

        widthEcran = 1200
        heightEcran = 675

        ##
        # Ajout du CSS aux bouton et on leur donne leur taille
        ajoutecssProvider(@aventure, aventureImage, widthOptionsPrincipales, heightOptionsPrincipales)
        ajoutecssProvider(@libre, libreImage, widthOptionsPrincipales * 0.7, heightOptionsPrincipales)
        ajoutecssProvider(@fermer, fermerImage, width, height)

        ##
        #Ajout des boutons et box dans les containers
        @boite.put(@aventure, (widthEcran *0.355), heightEcran * 0.53)
        @boite.put(@libre, (widthEcran *0.39), heightEcran * 0.68)
        @boite.put(@fermer, (widthEcran *0.63), heightEcran * 0.24)

        @win.add(@layoutManager)

        @win.show_all
    end

    ## Applique le css au bouton et lui applique la taille voulue
    ##
    # * +bouton+    Le bouton auquel appliqué les modifications
    # * +css+       Le css a appliqué
    # * +witdh+     Largeur voulue pour le bouton
    # * +height+     Hauteur voulue pour le bouton
    def ajoutecssProvider(bouton, css, width, height)
        bouton.style_context.add_provider(css, Gtk::StyleProvider::PRIORITY_USER)
        bouton.set_size_request(width, height)
    end

    ##
    # Crée et retourne le css correspondant à l'état passé
    ##
    # * +etat+  le css demandé par l'user, 1 css sans hover, 2 avec hover
    def ajouteCss(etat)

        css = Gtk::CssProvider.new

        if etat == 1

            css.load(data: <<-CSS)
            button {
                opacity: 0;
                border: unset;
            }
            CSS
        else
            css.load(data: <<-CSS)
            button {
                opacity: 0;
                border: unset;
            }
            button:hover {
                opacity: 0.1;
                border: 1px solid black;
            }
            CSS
        end
        return css
    end

    ##
    # Permet de changer la fenetre pour aller afficher l'écran aventure
    def vers_jeu()
        @win.remove(@layoutManager)
        @ecr = Ecran_aventure.creer(@win)
    end

    ##
    # Permet de changer la fenetre pour aller afficher l'écran libre
    def vers_libre()
        @win.remove(@layoutManager)
        @ecr = Ecran_libre.creer(@win)
    end

    ##
    # Permet de changer la fenetre pour aller afficher l'écran de jeu
    def vers_menu()
        @win.remove(@layoutManager)
        @ecr = Ecran_menu.creer(@win)
    end
end