
##
# Classe qui permet d'accèder au menu principal
##
# * +win+               La fenetre de l'application
# * +layoutManager+     Le layout principal pour le placement dans la fenetre
class Ecran_menu
    

    def Ecran_menu.creer(win)
        new(win)
    end

    private_class_method :new

    ##
    # Création du contenu de l'écran du menu principal
    ##
    # * +win+   La fenetre de l'application
    def initialize(win)
        @win = win

        boite = Gtk::Fixed.new()
        @layoutManager = Gtk::Box.new(:vertical)

        jouer = Gtk::Button.new(:label => "")
        tuto = Gtk::Button.new(:label => "")
        option = Gtk::Button.new(:label => "")
        quitter = Gtk::Button.new(:label => "")

        boite.add(Gtk::Image.new(:file => "../maquettes/menu.png"))
        @layoutManager.add(boite)

        ##
        # Ajout des signaux des boutons
        quitter.signal_connect("clicked"){
            @win.destroy
            Gtk.main_quit
            begin
                exit!
            rescue SystemExit
            end
        }
        jouer.signal_connect("clicked"){
            vers_jeu()
        }
        tuto.signal_connect("clicked"){
            vers_tuto()
        }
        option.signal_connect("clicked"){
            vers_options()
        }

        ##
        # Création des CSS pour les boutons 
        jouerImage = ajouteCss(2)
        tutoImage = ajouteCss(2)
        optionImage = ajouteCss(2)
        quitterImage = ajouteCss(2)

        widthOptionsPrincipales = 500
        heightOptionsPrincipales = 100
        width = 280
        height = 57

        widthEcran = 1200
        heightEcran = 675

        ##
        # Ajout du CSS aux bouton et on leur donne leur taille
        ajoutecssProvider(jouer, jouerImage, widthOptionsPrincipales, heightOptionsPrincipales)
        ajoutecssProvider(option, optionImage, widthOptionsPrincipales * 1.3, heightOptionsPrincipales)
        ajoutecssProvider(tuto, tutoImage, widthOptionsPrincipales * 1.37, heightOptionsPrincipales * 1.05)
        ajoutecssProvider(quitter, quitterImage, width, height)

        ##
        #Ajout des boutons et box dans les containers
        boite.put(jouer, (widthEcran *0.243), heightEcran * 0.34)
        boite.put(tuto, (widthEcran *0.15), heightEcran * 0.53)
        boite.put(option, (widthEcran *0.18), heightEcran * 0.73)
        boite.put(quitter, (widthEcran *0.75) , heightEcran * 0.89)

        @win.add(@layoutManager)

        #######################################################
        aDelete = Gtk::Button.new(:label => "Jeu")
        aDelete.signal_connect("clicked"){
            @win.remove(@layoutManager)
            Ecran_jeu.creer(@win)
        }
        boite.put(aDelete, 0 , 0)
        #######################################################

        @win.show_all
        Gtk.main
    end

    ##
    # Permet de changer la fenetre pour aller afficher l'écran de jeu
    def vers_jeu()
        @win.remove(@layoutManager)
        EcranJouer.creer(@win)
        return self
    end

    ##
    # Permet de changer la fenetre pour aller afficher l'écran du mode tutoriel
    def vers_tuto()
        @win.remove(@layoutManager)
        Tuto.creer(@win)
        return self
    end

    def vers_options()
        @win.remove(@layoutManager)
        EcranOptions.creer(@win)
        return self
    end
end