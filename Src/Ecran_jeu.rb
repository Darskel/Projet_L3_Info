load "Grille_jeu.rb"

##
# Représentation d'un écran de jeu, une partie de fill a pix
##
# * +win+               La fenêtre graphique du programme
# * +layoutManager+     Le layout principal pour le placement dans la fenetre
class Ecran_jeu

    ##
    # Constructeur de la classe
    ##
    # * +win+   La fenetre de l'application
    def Ecran_jeu.creer(win)
        new(win)
    end
    private_class_method :new

    ##
    # Placement et chargement des objets de l'écran, connection des signaux
    ##
    # * +win+   La fenetre de l'application
    def initialize(win)
        @win = win

        @layoutManager = Gtk::Box.new(:vertical, 5)
        espaceJeu = Gtk::Box.new(:horizontal, 5)

        joues = Array.new()

        grille = Grille_jeu.creer(true, joues, "../Grilles/tuto.txt")
        textfield1 = Gtk::Label.new("")
        textfield1.set_size_request(350, 200) 
        undo = Gtk::Button.new(:label => "Undo")
        redSquare = Gtk::Button.new(:label => "redSquare")
        procCoupLog = Gtk::Button.new(:label =>"Prochain coup logique")
        check = Gtk::Button.new(:label => "Check")
        aide = Gtk::Button.new(:label => "Fill 9")
        quit = Gtk::Button.new(:label => "Quitter")
        temps = Gtk::Label.new("Temps : ")
        chrono = Chronometre.creer(temps, 0, 0)

        procCoupLog.signal_connect("clicked"){
            chrono.augmenteTemps(60)
        }

        quit.signal_connect("clicked"){
            chrono.thr.kill
            vers_menu()
        }
        undo.signal_connect("clicked"){
            if !joues.empty?
                coup = joues.pop()
                grille.undo(coup)
            end
        }
        check.signal_connect("clicked"){
            fini = grille.check()

            if(fini[0] == true)
                puts("GG")
            else
                puts("NOPE")
                if(fini[1] == true)
                    chrono.augmenteTemps(30)
                end
            end
        }

        aide.signal_connect("clicked"){
            grille.fillNine('9')
            grille.fillNine('4')
            grille.fillNine('6')
            grille.fillNine('0')
        }

        redSquare.signal_connect("clicked"){
            grille.activeRedSquare()
        }

        espaceJeu.add(textfield1)
        espaceJeu.add(grille.grille)
        espaceJeu.add(temps)

        @layoutManager.add(undo)
        @layoutManager.add(check)
        @layoutManager.add(aide)
        @layoutManager.add(procCoupLog)
        @layoutManager.add(redSquare)
        @layoutManager.add(espaceJeu)
        @layoutManager.add(quit)
        
        @win.add(@layoutManager)

        @win.show_all
    end

    ##
    # Permet de passer à l'écran du menu
    def vers_menu()
        @win.remove(@layoutManager)
        Ecran_menu.creer(@win)
        return self
    end
end