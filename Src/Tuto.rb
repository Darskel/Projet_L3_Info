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
        @precedent = Gtk::Button.new(:label => "Règle précédente")
        @retourMenu = Gtk::Button.new()
        @boutonBack = Gtk::Button.new()
        @boutonOptions = Gtk::Button.new()


         #Numero de la regle active
         index = 1;


        joues = Array.new #tableau des coups joués par l'utilisateur pour le undo

        #Ajout du fond 
        @box.add(Gtk::Image.new(:file => "../maquettes/TutorielV2.png"))
        @box2.add(@box)

        #Ajout des différents boutons, de leur css respectif ainsi que de leurs évents liés
        ajouteBouton(@box,@retourMenu,1,55,45,(1200 *0.015), 675 * 0.025,method(:vers_menu),@window,@box2)
        ajouteBouton(@box,@boutonBack,1,60,60,(1200*0.89), 675*0.02,nil,@window,@box2)
        ajouteBouton(@box,@boutonOptions,1,60,60,(1200*0.94), 675*0.02,nil,@window,@box2)
        @box.put(@suivant,(1200 *0.85), 675 * 0.5)
        ajouteBouton(@box,@precedent,1,35,25,(1200 *0.84),675 * 0.44,nil,@window,@box2)

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
        
        cssCache = Gtk::CssProvider.new
        cssVoir = Gtk::CssProvider.new

        cssVoir.load(data: <<-CSS)
        button {
            opacity:1;
        }
        CSS

        cssCache.load(data: <<-CSS)
        button {
            opacity:0;
        }
        CSS
        
        #signal pour le bouton regle suivante permettant de passer à la règle suivante
        @suivant.signal_connect("clicked"){
            index = index+1

            if index>1
                @precedent.style_context.add_provider(cssVoir,Gtk::StyleProvider::PRIORITY_USER)
            end

            if index>=10
                @suivant.style_context.add_provider(cssCache,Gtk::StyleProvider::PRIORITY_USER)
            end

            changerTexteRegle(index)
        }

        #Signal pour le bouton regle precedente permettant de revenir à la règle précédente
        @precedent.signal_connect("clicked"){
            index = index-1

            if index<2
                @precedent.style_context.add_provider(cssCache,Gtk::StyleProvider::PRIORITY_USER)
            end

            if index<=10
                @suivant.style_context.add_provider(cssVoir,Gtk::StyleProvider::PRIORITY_USER)
            end

            changerTexteRegle(index)
        }
        
        @grilleTuto = Grille_jeu.creer(true, joues)
        @box.put(@grilleTuto.grille, (1200 *0.31), 675 * 0.16)

        @window.add(@box2)
        @window.show_all
    end

    def changerTexteRegle(index)
        case index
        when 1 
            @techniqueText = "Première règle : Toutes \n     les cases autour d'une \n       case 0 sont grises."
            @labelTechnique.set_text(@techniqueText)  
        when 2
            @techniqueText = "Deuxième règle : Toutes \n     les cases autour d'une \n       case 9 sont noires."
            @labelTechnique.set_text(@techniqueText)
        when 3 
            @techniqueText = "Troisième règle : Si \n     une case 6 se trouve \n     sur un bord de la grille \n alors toutes les cases \n autour sont noires."
            @labelTechnique.set_text(@techniqueText)
        when 4 
            @techniqueText = "Quatrième règle : Si \n     une case 4 se trouve \n    dans un coin de la grille \n alors toutes les cases  \n autour sont noires."
            @labelTechnique.set_text(@techniqueText)
        when 5 
            @techniqueText = "Cinquième règle : A partir\n   des cases déjà remplies,\n de nouvelles possibilités \n s'offre à vous alors \nvérifiez la grille à \n       nouveau !"
            @labelTechnique.set_text(@techniqueText)
        when 6 
            @techniqueText = "Sixième règle :"
            @labelTechnique.set_text(@techniqueText)
        when 7 
            @techniqueText = "Septième règle :"
            @labelTechnique.set_text(@techniqueText)
        when 8
            @techniqueText = "Huitième règle :"
            @labelTechnique.set_text(@techniqueText)
        when 9
            @techniqueText = "Neufième règle :"
            @labelTechnique.set_text(@techniqueText)
        when 10 
            @techniqueText = "Dixième règle :"
            @labelTechnique.set_text(@techniqueText)
        end
    end
    
end