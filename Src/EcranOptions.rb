
##
# La classe qui gère l'affichage et l'interaction avec le menu options qui permet 
#d'enlever le son, accéder au classement, aux credits et aux succès

##
# * +win+               La fenetre de l'application
# * +layoutManager+     Le layout principal pour le placement dans la fenetre
class EcranOptions
    

    ##
    # Constructeur de la classe
    ##
    # * +win+   La fenetre de l'application
    def EcranOptions.creer(win)
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

        succes = Gtk::Button.new(:label => "")
        classement = Gtk::Button.new(:label => "")
        credits = Gtk::Button.new(:label => "")
        quitter = Gtk::Button.new(:label => "")
        sons = Gtk::CheckButton.new("")
        sons.active=true

        boite.add(Gtk::Image.new(:file => "../maquettes/menu-options.png"))
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

        widthEcran = 1200
        heightEcran = 675

        ajouteBouton(boite, succes, 2, 420, heightOptionsPrincipales, (widthEcran *0.31), heightEcran * 0.56, nil, @win, @layoutManager)
        ajouteBouton(boite, classement, 2, 550, heightOptionsPrincipales, (widthEcran *0.27),  heightEcran * 0.67, nil, @win, @layoutManager)
        ajouteBouton(boite, credits, 2, 430, heightOptionsPrincipales, (widthEcran *0.31), heightEcran * 0.79, nil, @win, @layoutManager)
        ajouteBouton(boite, quitter, 1, width, height, (widthEcran *0.72), heightEcran * 0.24, nil, @win, @layoutManager)
        
        boite.put(sons, (widthEcran *0.65), heightEcran * 0.50)

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