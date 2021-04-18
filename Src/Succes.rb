##
# La classe qui gère l'affichage des succès du joueur ou ceux qu'il n'a pas encore validés
##
# * +win+               La fenetre de l'application
# * +layoutManager+     Le layout principal pour le placement dans la fenetre
load "Utils.rb"

class Succes
    

    ##
    # Constructeur de la classe
    ##
    # * +win+   La fenetre de l'application
    def Succes.creer(win)
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
        
        flecheRetour = Gtk::Button.new(:label => "")

        boite.add(Gtk::Image.new(:file => "../maquettes/succes.png"))
        @layoutManager.add(boite)

        ##
        # Ajout du sigal du bouton retour
        flecheRetour.signal_connect("clicked"){
            vers_menuSucces()
        }
        
        width = 31
        height = 19

        @widthEcran = $widthEcran
        @heightEcran = $heightEcran

        ajouteBouton(boite, flecheRetour, 2, 65, 60, 20, 10, nil, nil, nil)

        @win.add(@layoutManager)

        afficherSucces(boite)
        @win.show_all
    end

    ##
    # Permet de changer la fenetre pour aller afficher le menu principalm
    def vers_menuSucces()
        @win.remove(@layoutManager)
        Ecran_menu.creer(@win)
        return self
    end

    ##
    # Affiche les succès en faisant varier la couleur de police afin de voir quels sont les succès validés par l'utilisateur et ceux qu'il n'a pas encore accompli
    # * +boite+     Gtk::box qui contiendra les différents lablels des succes
    def afficherSucces(boite)
        file = File.open($userPath + "succes.txt")
        file_data = file.readlines.map(&:chomp)

        positionText = @widthEcran * 0.1

        succesTuto = Gtk::Label.new("Vous avez fini le tutoriel !")
        succes1 = Gtk::Label.new("Niveau 1 terminé ! Bravo matelot !")
        succes2 = Gtk::Label.new("Niveau 2 terminé ! ")
        succes3 = Gtk::Label.new("Niveau 3 terminé ! Vous passez officier !")
        succes4 = Gtk::Label.new("Niveau 4 terminé ! Félicitation !")
        succes5 = Gtk::Label.new("Niveau 5 terminé ! Promotion : lieutenant")
        succes6 = Gtk::Label.new("Niveau 6 terminé ! ")
        succes7 = Gtk::Label.new("Niveau 7 terminé ! Quel parcours incroyable !")
        succes8 = Gtk::Label.new("Niveau 8 terminé ! Promotion : capitaine")
        succes9 = Gtk::Label.new("Niveau 9 terminé ! Juste trop fort !")
        succes10 = Gtk::Label.new("Niveau 10 terminé ! Vous êtes désormais vice-amiral !")
        succesAll = Gtk::Label.new("Vous avez terminé tous les succès et êtes au plus haut rang possible dans la marine!!!")

        cssNoir = ajouteTexte(3)
        cssGris = ajouteTexte(4)

        for numLigne in (0..11) do
            ligneFich = file_data[numLigne].split(" ")
            res = ligneFich[0]

            ## 
            # Application d'un css noir si l'utilisateur a validé le succès
            case numLigne
            when 0
                if res == "true" then
                    ajoutecssProvider(succes1, cssNoir, 1000,25)
                else
                    ajoutecssProvider(succes1, cssGris, 1000,25)
                end
                boite.put(succes1, positionText, @heightEcran * 0.29)
            when 1
                if res == "true" then
                    ajoutecssProvider(succes2, cssNoir, 1000,25)
                else
                    ajoutecssProvider(succes2, cssGris, 1000,25)
                end
                boite.put(succes2, positionText, @heightEcran * 0.35)
            when 2
                if res == "true" then
                    ajoutecssProvider(succes3, cssNoir, 1000,25)
                else
                    ajoutecssProvider(succes3, cssGris, 1000,25)
                end
                boite.put(succes3, positionText, @heightEcran * 0.41)
            when 3
                if res == "true" then
                    ajoutecssProvider(succes4, cssNoir, 1000,25)
                else
                    ajoutecssProvider(succes4, cssGris, 1000,25)
                end
                boite.put(succes4, positionText, @heightEcran * 0.47)
            when 4
                if res == "true" then
                    ajoutecssProvider(succes5, cssNoir, 1000,25)
                else
                    ajoutecssProvider(succes5, cssGris, 1000,25)
                end
                boite.put(succes5, positionText, @heightEcran * 0.53)
            when 5
                if res == "true" then
                    ajoutecssProvider(succes6, cssNoir, 1000,25)
                else
                    ajoutecssProvider(succes6, cssGris, 1000,25)
                end
                boite.put(succes6, positionText, @heightEcran * 0.59)
            when 6
                if res == "true" then
                    ajoutecssProvider(succes7, cssNoir, 1000,25)
                else
                    ajoutecssProvider(succes7, cssGris, 1000,25)
                end
                boite.put(succes7, positionText, @heightEcran * 0.65)
            when 7
                if res == "true" then
                    ajoutecssProvider(succes8, cssNoir, 1000,25)
                else
                    ajoutecssProvider(succes8, cssGris, 1000,25)
                end
                boite.put(succes8, positionText, @heightEcran * 0.71)
            when 8
                if res == "true" then
                    ajoutecssProvider(succes9, cssNoir, 1000,25)
                else
                    ajoutecssProvider(succes9, cssGris, 1000,25)
                end
                boite.put(succes9, positionText, @heightEcran * 0.77)
            when 9
                if res == "true" then
                    ajoutecssProvider(succes10, cssNoir, 1000,25)
                else
                    ajoutecssProvider(succes10, cssGris, 1000,25)
                end
                boite.put(succes10, positionText, @heightEcran * 0.83)
            when 10
                if res == "true" then
                    ajoutecssProvider(succesTuto, cssNoir, 1000,25)
                else
                    ajoutecssProvider(succesTuto, cssGris, 1000,25)
                end
                boite.put(succesTuto, positionText, @heightEcran * 0.23)
            when 11
                if res == "true" then
                    ajoutecssProvider(succesAll, cssNoir, 1000,25)
                    boite.put(succesAll, positionText, @heightEcran * 0.89)
                end
            end

        end
        return self
    end

end