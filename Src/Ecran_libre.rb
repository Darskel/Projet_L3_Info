##
# Représentation d'un écran de jeu, une partie de fill a pix
##
# * +win+               La fenêtre graphique du programme
# * +layoutManager+     Le layout principal pour le placement dans la fenetre
class Ecran_libre
    
    ##
    # Constructeur de la classe
    ##
    # * +win+   La fenetre de l'application
    def Ecran_libre.creer(win)
        new(win)
    end

    private_class_method :new

    ##
    # Construction de l'instance
    ##
    # * +win+   La fenetre de l'application
    def initialize(win)
        @win = win

        @boite = Gtk::Fixed.new()
        @container = Gtk::Box.new(:vertical)

        @retourMenu = Gtk::Button.new(:label => "")
        @nouvellePartie = Gtk::Button.new(:label => "")
        @reprendre = Gtk::Button.new(:label => "")
        defilerChapitres = Gtk::Button.new(:label => "")

        btnChapitre = [
            Gtk::Button.new(),
            Gtk::Button.new(),
            Gtk::Button.new(),
            Gtk::Button.new(),
            Gtk::Button.new()
        ]

        lblChapitre = [
            Gtk::Label.new(""),
            Gtk::Label.new(""),
            Gtk::Label.new(""),
            Gtk::Label.new(""),
            Gtk::Label.new("")
        ]

        @boite.add(Gtk::Image.new(:file => "../maquettes/menu-libre.png"))
        @container.add(@boite)
        
        ajouteBouton(@boite, @nouvellePartie, 2, 520, 50, 450, 450, nil, nil, nil)
        ajouteBouton(@boite, @reprendre, 2, 350, 50, 545, 545, nil, nil, nil)

        cssChapitre = ajouteTexte(3)

        addChapitre(btnChapitre[0], lblChapitre[0], 13, 20, cssChapitre)
        addChapitre(btnChapitre[1], lblChapitre[1], 13, 155, cssChapitre)
        addChapitre(btnChapitre[2], lblChapitre[2], 13, 285, cssChapitre)
        addChapitre(btnChapitre[3], lblChapitre[3], 13, 420, cssChapitre)
        addChapitre(btnChapitre[4], lblChapitre[4], 13, 550, cssChapitre)

        ajouteBouton(@boite, defilerChapitres, 2, 45, 45, 230, 620, method(:actualiserChapitres), lblChapitre, nil)
        ajouteBouton(@boite, @retourMenu, 2, 60, 60, 20, 5, method(:vers_menu), @win, @container)


        @win.add(@container)

        @grille = Grille_jeu.creer(false, Array.new, "../Grilles/grille_chapitre3.txt")
        @boite.put(@grille.grille, (1200 *0.4), 675 * 0.12)

        file = File.open("chapitres.txt")
        lignes = file.readlines
        @nbLignes = lignes.size
        @file_data = lignes.map(&:chomp)

        file.close

        @i_chap = 0
        actualiserChapitres(lblChapitre)

        @win.show_all
        Gtk.main

        return self
    end

    ##
    # Ajoute un chapitre dans la boite
    ##
    # * +bouton+ Le bouton contenant le label
    # * +label+  Le label à styliser
    # * +css+    Le css a appliquer
    # * +x+      Position en abscisse
    # * +y+      Postion en ordonnée
    def addChapitre(bouton, label, x, y, css) 
        ajouteBouton(@boite, bouton, 3, 260, 115, x, y, method(:eventChangerChapitre), nil, nil)
        
        ajouteTexteProvider(label, css)
        bouton.add(label)
    end

    ##
    # Change la grille en fonction du chapitre sélectionné
    ##
    def eventChangerChapitre()
        @grille.recharger("../Grilles/grille_chat.txt")
    end

    ##
    # Permet de changer les chapitres à l'appuie sur la flèche
    def actualiserChapitres(lblChapitre)
        lblChapitre.each {|lbl| lbl.label = nextChapitre() }
           
        return self
    end

    ##
    # Charge le texte d'un chapitre dans le label
    def nextChapitre()
        until (@file_data[@i_chap].gsub("    ", "").start_with?("Chapitre"))
            @i_chap += 1

            if @i_chap == @nbLignes
                @i_chap = 0
            end
        end
        str = @file_data[@i_chap].gsub("    ", "").gsub(": ", "\n")
        if (str.size > 27)
            str = str[0...-6] + "..."
        elsif (str.size < 23)
            str.insert(12, '♦')
            str = str.gsub("♦", "     ")
        end

        @i_chap += 1
        return "   " + str
    end

end