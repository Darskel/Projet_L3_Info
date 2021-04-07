load "Grille_jeu.rb"
load "Utils.rb"
load "Grille_jeu_charger.rb"
##
# Classe qui permet d'accèder au menu principal
##
# * +win+               La fenetre de l'application
# * +layoutManager+     Le layout principal pour le placement dans la fenetre
class Ecran_jeu
    private_class_method :new

    attr_reader :chrono, :grille

    ##
    # Constructeur
    ##
    # * +win+       Fenetre graphique de l'application
    def Ecran_jeu.creer(win, map)
        new(win, map)
    end

    ##
    # Construction de l'instance
    ##
    # * +win+       Fenetre graphique de l'application
    def initialize(win, map)
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
        chrono = Chronometre.creer(temps)

        joues = Array.new #tableau des coups joués par l'utilisateur pour le undo

        #Ajout du fond 
        @box.add(Gtk::Image.new(:file => "../maquettes/Jeu.png"))
        @box2.add(@box)

        #Ajout des différents boutons, de leur css respectif ainsi que de leurs évents liés
        ajouteBouton(@box,@retourMenu,1,55,45,(1200 *0.015), 675 * 0.025,method(:vers_menu),@window,@box2)
        ajouteBouton(@box,@boutonCoupLogique,1,60,60,(1200*0.899), 675*0.015,nil,@window,@box2)
        ajouteBouton(@box,@boutonCheck,1,60,60,(1200*0.855), 675*0.015,nil,@window,@box2)
        ajouteBouton(@box,@boutonCurseur,1,60,60,(1200*0.812), 675*0.015,nil,@window,@box2)
        ajouteBouton(@box,@boutonUndo,1,60,60,(1200*0.767), 675*0.015,nil,@window,@box2)
        ajouteBouton(@box,@boutonRemplissage,1,60,60,(1200*0.942), 675*0.015,nil,@window,@box2)
        @box.put(temps,450,630)

        #lance une grille vierge de coups si aucune sauvegarde existe 
        #concernant la map et le mode voulu
        if(Grille_jeu_charger.exist?(map, "Libre"))
            @grille = Grille_jeu_charger.creer(true, joues, map, chrono, "Libre")
        else
            @grille = Grille_jeu.creer(true, joues, map)
            chrono.lancer(0,0)
        end

        
        #Sauvegarde la grille quand on la quitte et arrête le chrono
        @retourMenu.signal_connect("clicked"){
            @grille.sauveProgression(chrono, "Libre")
            chrono.kill
        }
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
                chrono.kill
                ecran_victoire(chrono)
            else
                if(fini[1] == true)
                    chrono.augmenteTemps(30)
                end
            end
        }
        
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

    ##
    # Déclenche l'écran de victoire quand le joueur gagne
    ##
    # * +chrono+        Le temps de la partie
    def ecran_victoire(chrono)
        @box2.remove(@box)

        box = Gtk::Fixed.new()

        duree = "Partie finie en " + chrono.minutes.to_s + ":" + chrono.secondes.to_s

        @box2.add(box)

        box.add(Gtk::Image.new(:file => "../maquettes/Jeu.png"))

        messageVictoire = Gtk::Label.new("Félicitations vous avez terminé le niveau !")
        buttonMenu = Gtk::Button.new(:label => "Retour au menu")
        temps = Gtk::Label.new(duree)

        box.put(messageVictoire, (1200 *0.28), 675 * 0.16)
        box.put(buttonMenu, (1200 *0.28), 675 * 0.9)
        box.put(temps, (1200 *0.28), 675 * 0.5)

        buttonMenu.signal_connect("clicked"){
            vers_menu(@window, @box2)
        }

        @window.show_all
    end
end