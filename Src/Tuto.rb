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
        @boutonUndo = Gtk::Button.new()
        @boutonOptions = Gtk::Button.new()


        #Css des boutons
        @cssCache = Gtk::CssProvider.new
        cssVoir = Gtk::CssProvider.new

        cssVoir.load(data: <<-CSS)
        button {
            opacity:1;
        }
        CSS

        @cssCache.load(data: <<-CSS)
        button {
            opacity:0;
        }
        CSS

         #Numero de la regle active
         index = 1;


        joues = Array.new #tableau des coups joués par l'utilisateur pour le undo

        #Ajout du fond 
        @box.add(Gtk::Image.new(:file => "../maquettes/TutorielV2.png"))
        @box2.add(@box)

        #Ajout des différents boutons, de leur css respectif ainsi que de leurs évents liés
        ajouteBouton(@box,@retourMenu,1,55,45,(1200 *0.015), 675 * 0.025,method(:vers_menu),@window,@box2)
        ajouteBouton(@box,@boutonUndo,1,60,60,(1200*0.899), 675*0.015,nil,@window,@box2)
        ajouteBouton(@box,@boutonOptions,1,60,60,(1200*0.94), 675*0.02,nil,@window,@box2)
        ajoutecssProvider(@suivant,cssVoir,150,25)
        @box.put(@suivant,(1200 *0.84), 675 * 0.4)
        ajouteBouton(@box,@precedent,1,150,25,(1200 *0.05),675 * 0.4,nil,@window,@box2)
        
        #Placement du texte dans la bulle du capitaine
        techniqueTextCss = ajouteTexte(2)
        @techniqueText = "Première règle : Aucune case autour \nd'une case 0 n'est valide."
        @labelTechnique = Gtk::Label.new(@techniqueText)
        ajouteTexteProvider(@labelTechnique,techniqueTextCss,60,60)
        @box.put(@labelTechnique,(1200 *0.3), 675 * 0.84)

        #signal du bouton undo afin de retourner au coup précédemment joué
        @boutonUndo.signal_connect("clicked"){ # signal pour le bouton undo
            if !joues.empty?
                coup = joues.pop()
                @grilleTuto.undo(coup)
            end
        }
        
        #signal pour le bouton regle suivante permettant de passer à la règle suivante
        @suivant.signal_connect("clicked"){
            index = index+1
            if index>1
                @precedent.sensitive = true
                @precedent.style_context.add_provider(cssVoir,Gtk::StyleProvider::PRIORITY_USER)
            end

            if index>=11
                @suivant.style_context.add_provider(@cssCache,Gtk::StyleProvider::PRIORITY_USER)
                @suivant.sensitive = false
            end
            changerTexteRegle(index)
        }

        #Signal pour le bouton regle precedente permettant de revenir à la règle précédente
        @precedent.signal_connect("clicked"){
            index = index-1
            if index<2
                @precedent.style_context.add_provider(@cssCache,Gtk::StyleProvider::PRIORITY_USER)
                @precedent.sensitive = false
            end

            if index<11
                @suivant.sensitive = true
                @suivant.style_context.add_provider(cssVoir,Gtk::StyleProvider::PRIORITY_USER)
            end
            changerTexteRegle(index)
        }
        
        @grilleTuto = Grille_jeu.creer(true, joues)
        @box.put(@grilleTuto.grille, (1200 *0.28), 675 * 0.16)

        @window.add(@box2)
        @window.show_all
    end

    #Fonction permettant de changer le texte présent dans le label de la bulle du capitaine en fonction du 
    def changerTexteRegle(index)
        
        cssAidePresentee = Gtk::CssProvider.new
        cssAidePresentee.load(data: <<-CSS)
        button {
            opacity: 0.5;
            border: 1px groove red;
            box-shadow: 0 0 0 5px red inset;
        }
        CSS
        
        case index
        when 1 
            @techniqueText = "Première règle : Aucune case autour \nd'une case 0 n'est valide."
            @labelTechnique.set_text(@techniqueText)  
        when 2
            @techniqueText = "Deuxième règle : Toutes les cases autour \nd'une case 9 sont noires."
            @labelTechnique.set_text(@techniqueText)
        when 3 
            @techniqueText = "Troisième règle : Si une case 6 se trouve \nsur un bord de la grille alors toutes les cases\nautour sont noires."
            @labelTechnique.set_text(@techniqueText)
        when 4 
            @techniqueText = "Quatrième règle : Si une case 4 se trouve \ndans un coin de la grille alors toutes les cases\nautour sont noires."
            @labelTechnique.set_text(@techniqueText)
        when 5 
            @techniqueText = "Cinquième règle : A partir des cases déjà \nremplies, de nouvelles possibilités s'offre à\nvous alors vérifiez la grille à nouveau !"
            @labelTechnique.set_text(@techniqueText)
        when 6 
            @boutonUndo.style_context.add_provider(@cssCache,Gtk::StyleProvider::PRIORITY_USER)
            @techniqueText = "Passons maintenant aux aides que vous\npouvez utiliser !"
            @labelTechnique.set_text(@techniqueText)

        when 7 
            @boutonUndo.style_context.add_provider(cssAidePresentee,Gtk::StyleProvider::PRIORITY_USER)
            @techniqueText = "Première aide disponible : Ce bouton vous\npermet d'annuler le coup que vous venez de\nréaliser, vous revenez ainsi en arrière."
            @labelTechnique.set_text(@techniqueText)
        when 8
            @boutonUndo.style_context.add_provider(@cssCache,Gtk::StyleProvider::PRIORITY_USER)
            @techniqueText = "Deuxième aide disponible : Ce bouton vous\npermet de vérifier si tous les coups que\nvous avez joué sont corrects ou non."
            @labelTechnique.set_text(@techniqueText)
        when 9
            @techniqueText = "Troisième aide disponible : Ce bouton vous\npermet de remplir automatiquement les cases\n9,6,4 et 0."
            @labelTechnique.set_text(@techniqueText)
        when 10 
            @techniqueText = "Quatrième aide disponible : Ce bouton vous\npermet d'afficher votre curseur en\nsélectionnant un carré de 3 cases par 3."
            @labelTechnique.set_text(@techniqueText)
        when 11
            @techniqueText = "Cinquième aide disponible : Ce bouton vous\npermet de prédir le prochain coup que vous pouvez jouer si vous êtes bloqué."
            @labelTechnique.set_text(@techniqueText)
        end
    end
    
end