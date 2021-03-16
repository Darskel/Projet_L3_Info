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

        @boite.add(Gtk::Image.new(:file => "../maquettes/menu-libre.png"))
        @container.add(@boite)
        
        ajouteBouton(@boite, @retourMenu, 1, 60, 60, 20, 5, method(:vers_menu), @win, @container)
        ajouteBouton(@boite, @nouvellePartie, 2, 520, 50, 450, 450, nil, nil, nil)
        ajouteBouton(@boite, @reprendre, 2, 350, 50, 545, 545, nil, nil, nil)

        @win.add(@container)

        @grille = Grille_jeu.creer(false, Array.new)
        @boite.put(@grille.grille, (1200 *0.4), 675 * 0.12)

        file = File.open("chapitres.txt")
        lignes = file.readlines
        nbLignes = lignes.size
        file_data = lignes.map(&:chomp)

        file.close

        i_deb = 0
        i_fin = 8

        text = "Chapitre 1"
        @boite.put(Gtk::Label.new(text), (1200 *0.16), 675 * 0.2)

        i = i_deb
        while (i <= i_fin)
            puts(file_data[i])

            i+=2
        end

        @win.show_all
        Gtk.main
    end

end