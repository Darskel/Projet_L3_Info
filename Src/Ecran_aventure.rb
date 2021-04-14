##
# Ecran qui permet à l'utilisateur de lancer une partie dans le menu aventure
##
# * +win+               La fenetre de l'application
# * +layoutManager+     Le layout principal pour le placement dans la fenetre
class Ecran_aventure
    
    ##
    # Constructeur
    ##
    # * +win La fenetre de l'application+
    def Ecran_aventure.creer(win)
        new(win)
    end

    private_class_method :new

    ##
    # Construction de l'instance
    ##
    # * +win+   La fenetre de l'application
    def initialize(win)
        @win = win

        boite = Gtk::Fixed.new()
        @layoutManager = Gtk::Box.new(:vertical)

        fleche = Gtk::Button.new(:label => "")
        demarrer = Gtk::Button.new(:label => "")
        reprendre = Gtk::Button.new(:label => "")
        progression = Gtk::Button.new(:label => "")
        quitter = Gtk::Button.new(:label => "")

        boite.add(Gtk::Image.new(:file => "../maquettes/menu-aventure.png"))
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

        widthOptionsPrincipales = 500
        heightOptionsPrincipales = 80
        width = 280
        height = 57

        heightEcran = 675
        widhtEcran = 1200

        chap = 45
        affiche_chapitre(chap, boite)

        ajouteBouton(boite, fleche, 2, 65, 60, 20, 10, method(:vers_menu), nil, nil)
        ajouteBouton(boite, demarrer, 2, widthOptionsPrincipales, heightOptionsPrincipales, widhtEcran * 0.25, heightEcran * 0.5, nil, nil, nil)
        ajouteBouton(boite, reprendre, 2, widthOptionsPrincipales, heightOptionsPrincipales, widhtEcran * 0.25, heightEcran * 0.65, nil, nil, nil)
        ajouteBouton(boite, progression, 2, widthOptionsPrincipales * 1.2, heightOptionsPrincipales, widhtEcran * 0.22, heightEcran * 0.8, method(:vers_progression), nil, nil)
        ajouteBouton(boite, quitter, 2, width, height, widhtEcran * 0.75, heightEcran * 0.885, nil, nil, nil)


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

    def vers_progression()
        @win.remove(@layoutManager)
        @ecr = Ecran_progression.creer(@win)
    end

    ##
    # Permet d'afficher le titre et la description du chapitre où est rendu le joueur
    ##
    # +chap+    Le numéro du chapitre à afficher
    # +boite+   La boite où placer les informations du chapitre
    def affiche_chapitre(chap, boite)
        widhtEcran = 1200
        chapitreTexte = ajouteTexte(1)
        descriptionTexte = ajouteTexte(2)
        file = File.open("chapitres.txt")
        file_data = file.readlines.map(&:chomp)
        nom_chapitre = file_data[chap]
        @labelChapitre = Gtk::Label.new(nom_chapitre)
        ajouteTexteProvider(@labelChapitre, chapitreTexte)
        boite.put(@labelChapitre, (widhtEcran *0.25), 50)
        placement = 170

        for i in chap+1..chap+4
            description = file_data[i]
            @labelDescription = Gtk::Label.new(description)
            ajouteTexteProvider(@labelDescription, descriptionTexte)
            boite.put(@labelDescription, 30, placement)
            placement += 30
        end

        file.close
    end
end