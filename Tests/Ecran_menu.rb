class Ecran_menu

    def Ecran_menu.creer(win)
        new(win)
    end

    private_class_method :new

    def initialize(win)
        @win = win
        @boite = Gtk::Box.new(:vertical, 5)

        @jouer = Gtk::Button.new(:label => "Jouer")
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
        Ecran_jeu.creer(@win)
    end
end