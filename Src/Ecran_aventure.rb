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

        boite = Gtk::Fixed.new()
        @layoutManager = Gtk::Box.new(:vertical)

        file = File.open("chapitres.txt")
        file_data = file.readlines.map(&:chomp)
        nom_chapitre = file_data[0]
        description = file_data[1]

        @labelChapitre = Gtk::Label.new(nom_chapitre)
        @labelDescription = Gtk::Label.new(description)

        file.close

        fleche = Gtk::Button.new(:label => "")
        demarrer = Gtk::Button.new(:label => "")
        reprendre = Gtk::Button.new(:label => "")
        progression = Gtk::Button.new(:label => "")
        quitter = Gtk::Button.new(:label => "")

        boite.add(Gtk::Image.new(:file => "../maquettes/menu-aventure.png"))
        @layoutManager.add(boite)

        ##
        # Ajout des signaux des boutons
        fleche.signal_connect("clicked"){
            vers_menu()
        }
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

        ##
        # Création des CSS pour les boutons 
        
        flecheImage = ajouteCss(2)
        demarrerImage = ajouteCss(2)
        reprendreImage = ajouteCss(2)
        progressionImage = ajouteCss(2)
        quitterImage = ajouteCss(2)
        descriptionTexte = ajouteTexte(2)
        chapitreTexte = ajouteTexte(1)
        

        widthOptionsPrincipales = 500
        heightOptionsPrincipales = 80
        width = 280
        height = 57

        heightEcran = 675
        widhtEcran = 1200

        ##
        # Ajout du CSS aux bouton et on leur donne leur taille

        ajoutecssProvider(fleche, flecheImage, 65, 60)
        ajoutecssProvider(demarrer, demarrerImage, widthOptionsPrincipales, heightOptionsPrincipales)
        ajoutecssProvider(reprendre, reprendreImage, widthOptionsPrincipales, heightOptionsPrincipales)
        ajoutecssProvider(progression, progressionImage, widthOptionsPrincipales * 1.2, heightOptionsPrincipales)
        ajoutecssProvider(quitter, quitterImage, width, height)
        ajouteTexteProvider(@labelChapitre, chapitreTexte, 10, 10)
        ajouteTexteProvider(@labelDescription, descriptionTexte, 10, 10)

        ##
        #Ajout des boutons et box dans les containers
        boite.put(fleche, 20, 10)
        boite.put(demarrer, (widhtEcran *0.25), heightEcran * 0.5)
        boite.put(reprendre, (widhtEcran *0.25), heightEcran * 0.65)
        boite.put(progression, (widhtEcran *0.22), heightEcran * 0.8)
        boite.put(quitter, (widhtEcran *0.75) , heightEcran * 0.885)
        boite.put(@labelChapitre, (widhtEcran *0.35), 50)
        boite.put(@labelDescription, 30, 170)

        @win.add(@layoutManager)

        @win.show_all
        Gtk.main
    end

    ##
    # Permet de changer la fenetre pour aller afficher l'écran de jeu
    def vers_menu()
        @win.remove(@layoutManager)
        @ecr = Ecran_menu.creer(@win)
    end

end