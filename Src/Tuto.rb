load "Grille_jeu.rb"
load "Utils.rb"
class Tuto

    private_class_method :new

    def Tuto.creer(win)
        new(win)
    end

    def initialize(win)
        #Création de l'interface 
        @window = win
        @box = Gtk::Fixed.new()
        @box2 = Gtk::Box.new(:horizontal)
        @suivant = Gtk::Button.new(:label => "Règle suivante")
        @retourMenu = Gtk::Button.new()
        @boutonBack = Gtk::Button.new()
        @boutonOptions = Gtk::Button.new()

        joues = Array.new #tableau des coups joués par l'utilisateur pour le undo

        #Ajout du fond 
        @box.add(Gtk::Image.new(:file => "../maquettes/TutorielV2.png"))
        @box2.add(@box)

        #Ajout des différents boutons, de leur css respectif ainsi que de leurs évents liés
        ajouteBouton(@box,@retourMenu,1,55,45,(1200 *0.015), 675 * 0.025,method(:vers_menu),@window,@box2)
        ajouteBouton(@box,@boutonBack,1,60,60,(1200*0.89), 675*0.02,nil,@window,@box2)
        ajouteBouton(@box,@boutonOptions,1,60,60,(1200*0.94), 675*0.02,nil,@window,@box2)
        @box.put(@suivant,(1200 *0.85), 675 * 0.5)

        #Placement du texte dans la bulle du capitaine
        @techniqueText = "Première règle : Aucune \n     case autour d'une \n       case 0 n'est valide "
        @labelTechnique = Gtk::Label.new(@techniqueText)
        @box.put(@labelTechnique,(1200 *0.16), 675 * 0.2)

        @boutonBack.signal_connect("clicked"){ # signal pour le bouton undo
            if !joues.empty?
                coup = joues.pop()
                @grilleTuto.undo(coup)
            end
        }
        
        
        @grilleTuto = Grille_jeu.creer(joues)
        @box.put(@grilleTuto.grille, (1200 *0.31), 675 * 0.16)

        @window.add(@box2)
        @window.show_all
    end
end