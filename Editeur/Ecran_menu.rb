class Ecran_menu

    def Ecran_menu.creer(win)
        new(win)
    end

    private_class_method :new

    def initialize(win)
        @win = win
        @boite = Gtk::Box.new(:vertical, 5)

        #----------------------------------

        @nbLignes = Gtk::Entry.new
        @nbColonnes = Gtk::Entry.new

        @boite.add(Gtk::Label.new('Nombre de lignes'))
        @boite.add(@nbLignes)
        @boite.add(Gtk::Label.new('Nombre de colonnes'))
        @boite.add(@nbColonnes)

        #----------------------------------

        @jouer = Gtk::Button.new(:label => "Lancer")
        @quitter = Gtk::Button.new(:label => "Quitter")

        @boite.add(@jouer)
        @boite.add(@quitter)

        @quitter.signal_connect("clicked"){
            Gtk.main_quit
        }
        @jouer.signal_connect("clicked"){
            vers_jeu()
        }

        @win.add(@boite)

        @win.show_all
        Gtk.main
    end

    def vers_jeu()
        @win.remove(@boite)
        Ecran_jeu.creer(@win, @nbLignes.text.to_i(), @nbColonnes.text.to_i())
    end
end