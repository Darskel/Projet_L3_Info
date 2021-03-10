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

        @win.show_all
        Gtk.main
    end

end