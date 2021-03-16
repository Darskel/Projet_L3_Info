
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

        ##
        # Création des CSS pour les boutons 
        succesImage = ajouteCss(2)
        classementImage = ajouteCss(2)
        creditsImage = ajouteCss(2)
        quitterImage = ajouteCss(1)

        widthOptionsPrincipales = 307
        heightOptionsPrincipales = 68
        width = 31
        height = 19

        widthEcran = 1200
        heightEcran = 675

        ##
        # Ajout du CSS aux bouton et on leur donne leur taille
        ajoutecssProvider(succes, succesImage, 420, heightOptionsPrincipales)
        ajoutecssProvider(classement, classementImage, 550, heightOptionsPrincipales)
        ajoutecssProvider(credits, creditsImage, 430, heightOptionsPrincipales)
        ajoutecssProvider(quitter, quitterImage, width, height)

        ##
        #Ajout des boutons et box dans les containers
        boite.put(succes, (widthEcran *0.31), heightEcran * 0.56)
        boite.put(classement, (widthEcran *0.27), heightEcran * 0.67)
        boite.put(credits, (widthEcran *0.31), heightEcran * 0.79)
        boite.put(quitter, (widthEcran *0.72), heightEcran * 0.24)
        boite.put(sons, (widthEcran *0.65), heightEcran * 0.50)

        @win.add(@layoutManager)

        @win.show_all
    end

    ##
    # Permet de changer la fenetre pour aller afficher le menu principal
    def vers_menu()
        @win.remove(@layoutManager)
        Ecran_menu.creer(@win)
    end
end