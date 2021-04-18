load "Grille_jeu.rb"
load "Utils.rb"

##
# La classe Tuto permet au joueur de découvrir le jeu au travers d'un tuto qui explique les règles du jeu  
##
# * +win+               La fenetre de l'application
# * +box2+              Le layout principal pour le placement dans la fenetre
# * +boutonUndo+        Le bouton permettant d'annuler une action
# * +boutonRemplissage+ Le bouton permettant de remplir automatiquement autour des chiffres 9 et 0 et 6 et 4 pour les coins
# * +boutonCheck+       Le bouton qui permet de vérifier les réponses du joueur
# * +boutonCurseur+     Bouton permettant d'afficher une zone de 8 cases autour du curseur
# * +boutonCoupLogique+ Bouton qui permet de lancer un algo qui montrera au joueur un coup valide jouable dans la continuité des actions précédentes
# * +cssCache+          Permet de cacher les boutons des règles précédents et suivantes selon la règle courante
class Tuto

    private_class_method :new

    ##
    # Constructeur
    ##
    # * +win+       Fenetre graphique de l'application
    def Tuto.creer(win)
        new(win)
    end

    ##
    # Construction de l'instance
    ##
    # * +win+       Fenetre graphique de l'application
    def initialize(win)
        #Création de l'interface 
        @window = win
        box = Gtk::Fixed.new()
        @box2 = Gtk::Box.new(:horizontal)
        suivant = Gtk::Button.new(:label => "Règle suivante")        
        precedent = Gtk::Button.new(:label => "Règle précédente")
        retourMenu = Gtk::Button.new()
        @boutonUndo = Gtk::Button.new()
        @boutonRemplissage = Gtk::Button.new()
        @boutonCheck = Gtk::Button.new()
        @boutonCurseur = Gtk::Button.new()
        @boutonCoupLogique = Gtk::Button.new();


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
        box.add(Gtk::Image.new(:file => "../maquettes/Tutoriel.png"))
        @box2.add(box)

        #Ajout des différents boutons, de leur css respectif ainsi que de leurs évents liés
        ajouteBouton(box,retourMenu,1,55,45,($widthEcran *0.015), $heightEcran * 0.025,method(:vers_menu),@window,@box2)
        ajouteBouton(box,@boutonCoupLogique,1,60,60,($widthEcran*0.899), $heightEcran*0.015,nil,@window,@box2)
        ajouteBouton(box,@boutonCheck,1,60,60,($widthEcran*0.855), $heightEcran*0.015,nil,@window,@box2)
        ajouteBouton(box,@boutonCurseur,1,60,60,($widthEcran*0.812), $heightEcran*0.015,nil,@window,@box2)
        ajouteBouton(box,@boutonUndo,1,60,60,($widthEcran*0.767), $heightEcran*0.015,nil,@window,@box2)
        ajouteBouton(box,@boutonRemplissage,1,60,60,($widthEcran*0.942), $heightEcran*0.015,nil,@window,@box2)
        ajoutecssProvider(suivant,cssVoir,150,25)
        box.put(suivant,($widthEcran *0.84), $heightEcran * 0.4)
        ajouteBouton(box,precedent,1,150,25,($widthEcran *0.05),$heightEcran * 0.4,nil,@window,@box2)
        
        #Placement du texte dans la bulle du capitaine
        techniqueTextCss = ajouteTexte(2)
        @techniqueText = "Première règle : Aucune case autour \nd'une case 0 n'est valide."
        @labelTechnique = Gtk::Label.new(@techniqueText)
        #ajouteTexteProvider(@labelTechnique,techniqueTextCss,60,60)
        ajouteTexteProvider(@labelTechnique,techniqueTextCss)
        box.put(@labelTechnique,($widthEcran *0.3), $heightEcran * 0.84)

        @grilleTuto = Grille_jeu.creer(true, joues, "../Grilles/tuto.txt")

        #signal pour activer le rectangle rouge autour du curseur
        @boutonCurseur.signal_connect("clicked"){
            @grilleTuto.activeRedSquare()
        }

        #signal qui remplit les cases faciles (9, 0)
        @boutonRemplissage.signal_connect("clicked"){
            @grilleTuto.fillNine('9')
            @grilleTuto.fillNine('4')
            @grilleTuto.fillNine('6')
            @grilleTuto.fillNine('0')
        }

        #signal du bouton undo afin de retourner au coup précédemment joué
        @boutonUndo.signal_connect("clicked"){ # signal pour le bouton undo
            if !joues.empty?
                coup = joues.pop()
                @grilleTuto.undo(coup)
            end
        }

        #signal qui vérifie la grille
        @boutonCheck.signal_connect("clicked"){
            fini = @grilleTuto.check()

            if(fini[0] == true)
                text = "Félicitations ! \nVous avez terminé la grille du tutoriel\n"
                @labelTechnique.set_text(text)

                lines = File.readlines($userPath+"succes.txt")
                lines[10] = "true 0 0\n"
                File.open($userPath+"succes.txt", 'w') { |f| f.write(lines.join) }
            end
        }

        #Signal du prochain coup logique
        @boutonCoupLogique.signal_connect("clicked"){
            verif = @grilleTuto.check()
            if(verif[0] == false && verif[1] == false)
                @grilleTuto.nextMove()
            end
        }
        
        #signal pour le bouton regle suivante permettant de passer à la règle suivante
        suivant.signal_connect("clicked"){
            index = index+1
            if index>1
                precedent.sensitive = true
                precedent.style_context.add_provider(cssVoir,Gtk::StyleProvider::PRIORITY_USER)
            end

            if index>=11
                suivant.style_context.add_provider(@cssCache,Gtk::StyleProvider::PRIORITY_USER)
                suivant.sensitive = false
            end
            changerTexteRegle(index)
        }

        #Signal pour le bouton regle precedente permettant de revenir à la règle précédente
        precedent.signal_connect("clicked"){
            index = index-1
            if index<2
                precedent.style_context.add_provider(@cssCache,Gtk::StyleProvider::PRIORITY_USER)
                precedent.sensitive = false
            end

            if index<11
                suivant.sensitive = true
                suivant.style_context.add_provider(cssVoir,Gtk::StyleProvider::PRIORITY_USER)
            end
            changerTexteRegle(index)
        }
        
        box.put(@grilleTuto.grille, ($widthEcran *0.28), $heightEcran * 0.16)

        @window.add(@box2)
        @window.show_all
    end

    ##
    # Fonction permettant de changer le texte présent dans le label de la bulle du capitaine en fonction du numéro de la règle
    ##
    # * +index+     Numéro de la règle
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
            @boutonCheck.style_context.add_provider(@cssCache,Gtk::StyleProvider::PRIORITY_USER)
            @boutonUndo.style_context.add_provider(cssAidePresentee,Gtk::StyleProvider::PRIORITY_USER)
            @techniqueText = "Première aide disponible : Ce bouton vous\npermet d'annuler le coup que vous venez de\nréaliser, vous revenez ainsi en arrière."
            @labelTechnique.set_text(@techniqueText)
        when 8
            @boutonUndo.style_context.add_provider(@cssCache,Gtk::StyleProvider::PRIORITY_USER)
            @boutonCurseur.style_context.add_provider(@cssCache,Gtk::StyleProvider::PRIORITY_USER)
            @boutonCheck.style_context.add_provider(cssAidePresentee,Gtk::StyleProvider::PRIORITY_USER)
            @techniqueText = "Deuxième aide disponible : Ce bouton vous\npermet de vérifier si tous les coups que\nvous avez joué sont corrects ou non."
            @labelTechnique.set_text(@techniqueText)
        when 9
            @boutonCheck.style_context.add_provider(@cssCache,Gtk::StyleProvider::PRIORITY_USER)
            @boutonRemplissage.style_context.add_provider(@cssCache,Gtk::StyleProvider::PRIORITY_USER)
            @boutonCurseur.style_context.add_provider(cssAidePresentee,Gtk::StyleProvider::PRIORITY_USER)
            @techniqueText = "Troisième aide disponible : Ce bouton vous\npermet d'afficher votre curseur en\nsélectionnant un carré de 3 cases par 3."
            @labelTechnique.set_text(@techniqueText)
        when 10 
            @boutonCurseur.style_context.add_provider(@cssCache,Gtk::StyleProvider::PRIORITY_USER)
            @boutonCoupLogique.style_context.add_provider(@cssCache,Gtk::StyleProvider::PRIORITY_USER)
            @boutonRemplissage.style_context.add_provider(cssAidePresentee,Gtk::StyleProvider::PRIORITY_USER)
            @techniqueText = "Quatrième aide disponible : En cliquant ici\nvous pouvez remplir automatiquement les\ncases 9,6,4 et 0 via la case à cocher."
            @labelTechnique.set_text(@techniqueText)
        when 11
            @boutonRemplissage.style_context.add_provider(@cssCache,Gtk::StyleProvider::PRIORITY_USER)
            @boutonCoupLogique.style_context.add_provider(cssAidePresentee,Gtk::StyleProvider::PRIORITY_USER)
            @techniqueText = "Cinquième aide disponible : Ce bouton vous\npermet d'afficher le prochain coup logique\nà faire lorsque vous êtes bloqués.Pensez d'abord\nà vérifier que toute votre grille est bonne !"
            @labelTechnique.set_text(@techniqueText)
        end
        return self
    end
end