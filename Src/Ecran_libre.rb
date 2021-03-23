class Ecran_libre
    

    def Ecran_libre.creer(win)
        new(win)
    end

    private_class_method :new

    ##
    #
    ##
    # * +win+   La fenetre de l'application
    def initialize(win)
        @win = win

        @boite = Gtk::Fixed.new()
        @container = Gtk::Box.new(:vertical)

        @retourMenu = Gtk::Button.new(:label => "")
        @nouvellePartie = Gtk::Button.new(:label => "")
        @reprendre = Gtk::Button.new(:label => "")
        @defilerChapitres = Gtk::Button.new(:label => "X")

        @boite.add(Gtk::Image.new(:file => "../maquettes/menu-libre.png"))
        @container.add(@boite)
        
        ajouteBouton(@boite, @retourMenu, 2, 60, 60, 20, 5, method(:vers_menu), @win, @container)
        ajouteBouton(@boite, @nouvellePartie, 2, 520, 50, 450, 450, nil, nil, nil)
        ajouteBouton(@boite, @reprendre, 2, 350, 50, 545, 545, nil, nil, nil)
        ajouteBouton(@boite, @defilerChapitres, 2, 45, 45, 230, 620, method(:actualiserChapitres), nil, nil)

        @win.add(@container)

        @grille = Grille_jeu.creer(false, Array.new)
        @boite.put(@grille.grille, (1200 *0.4), 675 * 0.12)

        file = File.open("chapitres.txt")
        lignes = file.readlines
        @nbLignes = lignes.size
        @file_data = lignes.map(&:chomp)

        file.close

        #Ajout selection chapitres
        cssChapitre = ajouteTexte(3)
        @lblChapitre1 = addChapitre(cssChapitre, 20, 20)
        @lblChapitre2 = addChapitre(cssChapitre, 20, 160)
        @lblChapitre3 = addChapitre(cssChapitre, 20, 290)
        @lblChapitre4 = addChapitre(cssChapitre, 20, 420)
        @lblChapitre5 = addChapitre(cssChapitre, 20, 550)

        @i_chap = 0
        actualiserChapitres()

        @win.show_all
        Gtk.main

        return self
    end

    def addChapitre(css, x, y)
        lblChapitre = Gtk::Label.new("")
        ajouteTexteProvider(lblChapitre, css)
        @boite.put(lblChapitre, x, y)

        return lblChapitre
    end

    def actualiserChapitres()
        @lblChapitre1.label = nextChapitre()
        @lblChapitre2.label = nextChapitre()
        @lblChapitre3.label = nextChapitre()
        @lblChapitre4.label = nextChapitre()
        @lblChapitre5.label = nextChapitre()
        
        return self
    end

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