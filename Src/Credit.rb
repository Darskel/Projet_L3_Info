##
# La classe qui gère l'affichage et l'interaction avec les crédits qui affiche 
# les noms des créateur de l'application

##
# * +win+               La fenetre de l'application
# * +layoutManager+     Le layout principal pour le placement dans la fenetre
class Credit
    
    ##
    # Constructeur de la classe
    ##
    # * +win+   La fenetre de l'application
    def Credit.creer(win)
        new(win)
    end

    private_class_method :new

    ##
    # Placement et chargement des objets de l'écran, connection des signaux
    ##
    # * +win+   La fenetre de l'application
    def initialize(win)
        @win = win

        boite = Gtk::Fixed.new()
        @layoutManager = Gtk::Box.new(:vertical)

        quitter = Gtk::Button.new(:label => "")

        boite.add(Gtk::Image.new(:file => "../maquettes/credits.png"))
        @layoutManager.add(boite)

        ##
        # Ajout des signaux des boutons
        quitter.signal_connect("clicked"){
            vers_menu()
        }

        widthOptionsPrincipales = 307
        heightOptionsPrincipales = 68
        width = 31
        height = 19

        widthEcran = $widthEcran
        heightEcran = $heightEcran

        ajouteBouton(boite, quitter, 1, width, height, (widthEcran *0.72), heightEcran * 0.24, nil, @win, @layoutManager)

        @win.add(@layoutManager)

        @win.show_all
    end

    ##
    # Permet de changer la fenetre pour aller afficher le menu principal
    def vers_menu()
        @win.remove(@layoutManager)
        Ecran_menu.creer(@win)
        return self
    end

end