load "Grille_jeu.rb"
load "Utils.rb"

##
# Classe qui permet d'accèder au menu principal
##
# * +win+               La fenetre de l'application
# * +layoutManager+     Le layout principal pour le placement dans la fenetre
class Chapitre1

    private_class_method :new

    ##
    # Constructeur
    ##
    # * +win+       Fenetre graphique de l'application
    def Chapitre1.creer(win)
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
        temps = Gtk::Label.new("Temps : ")
        chrono = Chronometre.creer(temps, 0, 0)

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
        
        @grille = Grille_jeu.creer(true, joues, "../Grilles/grille_femme.txt")

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

            if(fini == true)
                puts("GG")
            else
                puts("NOPE")
            end
        }
        
        @box.put(@grille.grille, (1200 *0.28), 675 * 0.16)

        @window.add(@box2)
        @window.show_all
    end
end