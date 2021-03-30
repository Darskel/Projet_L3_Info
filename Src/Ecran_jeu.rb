load "Grille_jeu.rb"
load "Utils.rb"

##
# Classe qui permet d'accèder au menu principal
##
# * +win+               La fenetre de l'application
# * +layoutManager+     Le layout principal pour le placement dans la fenetre
class Ecran_jeu
    private_class_method :new

    ##
    # Constructeur
    ##
    # * +win+       Fenetre graphique de l'application
    def Ecran_jeu.creer(win)
        new(win)
    end

    ##
    # Construction de l'instance
    ##
    # * +win+       Fenetre graphique de l'application
    def initialize(win)
        #Création de l'interface 
        @window = win
        @box = Gtk::Fixed.new()
        @box2 = Gtk::Box.new(:horizontal)
        @retourMenu = Gtk::Button.new()
        @boutonUndo = Gtk::Button.new()
        @boutonRemplissage = Gtk::Button.new()
        @boutonCheck = Gtk::Button.new()
        @boutonCurseur = Gtk::Button.new()
        @boutonCoupLogique = Gtk::Button.new();
        temps = Gtk::Label.new("")
        chrono = Chronometre.creer(temps, 0, 0)

        joues = Array.new #tableau des coups joués par l'utilisateur pour le undo

        #Ajout du fond 
        @box.add(Gtk::Image.new(:file => "../maquettes/Jeu.png"))
        @box2.add(@box)

<<<<<<< Updated upstream
        #Ajout des différents boutons, de leur css respectif ainsi que de leurs évents liés
        ajouteBouton(@box,@retourMenu,1,55,45,(1200 *0.015), 675 * 0.025,method(:vers_menu),@window,@box2)
        ajouteBouton(@box,@boutonCoupLogique,1,60,60,(1200*0.899), 675*0.015,nil,@window,@box2)
        ajouteBouton(@box,@boutonCheck,1,60,60,(1200*0.855), 675*0.015,nil,@window,@box2)
        ajouteBouton(@box,@boutonCurseur,1,60,60,(1200*0.812), 675*0.015,nil,@window,@box2)
        ajouteBouton(@box,@boutonUndo,1,60,60,(1200*0.767), 675*0.015,nil,@window,@box2)
        ajouteBouton(@box,@boutonRemplissage,1,60,60,(1200*0.942), 675*0.015,nil,@window,@box2)
        @box.put(temps,450,630)

        
        @grille = Grille_jeu.creer(true, joues, "../Grilles/grille_chapitre10.txt")
=======
        grille = Grille_jeu.creer(true, joues, "../Grilles/tuto.txt")
        textfield1 = Gtk::Label.new("")
        textfield1.set_size_request(350, 200) 
        undo = Gtk::Button.new(:label => "Undo")
        redSquare = Gtk::Button.new(:label => "redSquare")
        check = Gtk::Button.new(:label => "Check")
        aide = Gtk::Button.new(:label => "Fill 9")
        quit = Gtk::Button.new(:label => "Quitter")
        temps = Gtk::Label.new("Temps : ")
        chrono = Chronometre.creer(temps, 0, 0)
        saveProgression = Gtk::Button.new(:label => "Save Progression")
        loadProgression = Gtk::Button.new(:label => "Load Progression")
>>>>>>> Stashed changes

        
        #signal pour activer le rectangle rouge autour du curseur
        @boutonCurseur.signal_connect("clicked"){
            @grille.activeRedSquare()
        }

        #signal qui remplit les cases faciles (9, 0, 4, 6)
        @boutonRemplissage.signal_connect("clicked"){
            @grille.fillNine('9')
            @grille.fillNine('4')
            @grille.fillNine('6')
            @grille.fillNine('0')
        }

        #signal du bouton undo afin de retourner au coup précédemment joué
        @boutonUndo.signal_connect("clicked"){ # signal pour le bouton undo
            if !joues.empty?
                coup = joues.pop()
                @grille.undo(coup)
            end
        }

        #signal qui vérifie la grille
        @boutonCheck.signal_connect("clicked"){
            fini = @grille.check()

            if(fini[0] == true)
                puts("GG")
            else
                puts("NOPE")
                if(fini[1] == true)
                    chrono.augmenteTemps(30)
                end
            end
        }
<<<<<<< Updated upstream
=======

        aide.signal_connect("clicked"){
            grille.fillNine('9')
            grille.fillNine('4')
            grille.fillNine('6')
            grille.fillNine('0')
        }

        redSquare.signal_connect("clicked"){
            grille.activeRedSquare()
        }

        saveProgression.signal_connect("clicked"){
            grille.saveProgression(chrono.minutes, chrono.secondes, "Libre")
        }

        loadProgression.signal_connect("clicked"){
            grille.loadProgression("Libre")
        }

        espaceJeu.add(textfield1)
        espaceJeu.add(grille.grille)
        espaceJeu.add(temps)

        @layoutManager.add(undo)
        @layoutManager.add(check)
        @layoutManager.add(aide)
        @layoutManager.add(redSquare)
        @layoutManager.add(saveProgression)
        @layoutManager.add(loadProgression)
        @layoutManager.add(espaceJeu)
        @layoutManager.add(quit)
>>>>>>> Stashed changes
        
        if(@grille.nbLignes == 10)
            @box.put(@grille.grille, (1200 *0.28), 675 * 0.16)
        elsif(@grille.nbLignes == 15)
            @box.put(@grille.grille, (1200 *0.225), 675 * 0.16)
        else
            @box.put(@grille.grille, (1200 *0.17), 675 * 0.11)
        end

        @window.add(@box2)
        @window.show_all
    end
end