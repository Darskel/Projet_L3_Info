load "css.rb"
load "Bouttons_grille.rb"

##
# Représentation d'une grille de jeu
##
# * +grille+        Une Gtk::Grid qui représente le plateau de jeu
# * +boutons+      Tableau de boutons dans la grille
# * +css+           Les différents CSS utilisables
# * +joues+         Tableau des coups joués par l'utilisateur, permettant l'utilisation de la fonctionnalité undo
# * +nomGrille+     Le nom du fichier de la grille
# * +redSquare+     Boolean permettant de savoir si le rectangle rouge est actif
# * +boolFillNine+  Boolean permettant de savoir si un fill nine a été appelé
# * +nbLignes+      Nombre de lignes du fichier
# * +ligne_solution+ La ligne de la solution
# * +nbColonnes+    Nombre de colonnes du fichier
class Grille_jeu

    attr_reader :grille, :nbLignes, :boolFillNine, :nomSauvegarde

    ##
    # Constructeur de la classe
    ##
    # * +estJouable+    Boolean qui permet de rendre les boutons de la grille clickaque ou non
    # * +joues+         Tableau contenant les coups joues par l'utilisateur
    # * +nomGrille+     Le nom du fichier de la grille
    def Grille_jeu.creer(estJouable, joues, nomGrille)
        new(estJouable, joues, nomGrille)
    end

    private_class_method :new

    ##
    # Création de la grille
    ##
    # * +estJouable+    Boolean qui permet de rendre les boutons de la grille clickaque ou non
    # * +joues+         Tableau contenant les coups joues par l'utilisateur
    # * +nomGrille+     Le nom du fichier de la grille
    def initialize(estJouable, joues, nomGrille)
        @grille = Gtk::Grid.new()
        @boutons = Array.new(25)
        0.upto(25) do |i|
            @boutons[i] = Array.new(25)
        end
        @joues = joues

        @css = Css.new()
        @redSquare = false

        @boolFillNine = false
        charger(nomGrille)
        @nomGrille = nomGrille

        unless (estJouable)
            rendreNonJouable()
        end
    end

    ##
    # Rend tous les boutons de la grille non clickable
    def rendreNonJouable()
        0.upto(@nbLignes-1) do |i|
            0.upto(@nbColonnes-1) do |j|
                #Rend le bouton non cliquable
                @boutons[i][j].boutton.sensitive = false
                if @nbLignes == 20
                    csss = @css.cssWWidemenu
                elsif @nbLignes == 15
                    csss = @css.cssWMedmenu
                else 
                    csss = @css.cssW
                end
                @boutons[i][j].boutton.style_context.add_provider(csss, Gtk::StyleProvider::PRIORITY_USER)
            end
        end
        return self
    end

    ##
    # Charge la grille spécifiée en paramètre
    ##
    # * +nomGrille+    Le nom du fichier a charger
    def charger(nomGrille)
        @nomGrille = nomGrille
        file = File.open(nomGrille)
        file_data = file.readlines.map(&:chomp)
        ligne_grille = file_data[1]
        @@ligne_solution = file_data[2]
        @nbLignes = file_data[0].split(' ')[0].to_i
        @nbColonnes = file_data[0].split(' ')[1].to_i
        file.close

        if @nbLignes == 20
            csss = @css.cssWWide
        elsif @nbLignes == 15
            csss = @css.cssWMed
        else 
            csss = @css.cssW
        end
        
        i_bouton = 0
        0.upto(@nbLignes-1) do |i|
            0.upto(@nbColonnes-1) do |j|
                # création des boutons, connection des signaux et placement sur la grille
                @boutons[i][j] = Boutton_grille.creer(ligne_grille[i_bouton], csss, @joues, i, j, self)
                i_bouton += 1
                @boutons[i][j].signal(@css.cssW, @css.cssB, @css.cssG)

                @grille.attach(@boutons[i][j].boutton, j, i, 1, 1)
            end
        end
        return self
    end

    ##
    # Remet la couleur du bouton après un undo
    ##
    # * +coup+  le coup a restitué
    def undo(coup)
        @boutons[coup.indiceI][coup.indiceJ].couleur= coup.couleur
        @boutons[coup.indiceI][coup.indiceJ].updateCouleur(@css.cssW, @css.cssB, @css.cssG)
        return self
    end

    ##
    # Vérification de la grille demandée par l'utilisateur, retourne un tableau contenant 
    # en case 0 : false si la grille contient des erreurs/n'est pas terminée
    # en case 1 : vrai si l'utilisateur a fait une ou plusieurs erreur
    def check()
        file = File.open(@nomGrille)

        file_data = file.readlines.map(&:chomp)
            
        @ligne_solution = file_data[2]

        file.close

        tab = Array.new(2)

        succes = true
        mauvRep = false

        0.upto(@nbLignes-1) do |i|
            0.upto(@nbColonnes-1) do |j|

                if @boutons[i][j].couleur == "grey" && @ligne_solution[i * @nbLignes + j].to_i == 1
                    succes = false
                    @boutons[i][j].mauvaiseReponse(@css.falseReponse)
                    mauvRep = true
                elsif @boutons[i][j].couleur == "white" && @ligne_solution[i * @nbLignes + j].to_i == 1
                    succes = false
                end
                if @boutons[i][j].couleur == "black" && @ligne_solution[i * @nbLignes + j].to_i == 0
                    succes = false
                    @boutons[i][j].mauvaiseReponse(@css.falseReponse)
                    mauvRep = true
                end
            end
        end
        tab[0] = succes
        tab[1] = mauvRep
        return tab
    end

    ##
    # Rempli l'espace autour d'un nombre de cases noires ou grises selon le paramètre
    ##
    # * +nombre+    Le nombre que l'on souhaite voir être entouré de cases noires ou grises
    def fillNine(nombre)

        @boolFillNine = true
        
        if(nombre != '0')
            couleur = "black"
        else
            couleur = "grey"
        end

        possible = true

        0.upto(@nbLignes-1) do |i|
            0.upto(@nbColonnes-1) do |j|
                if(@boutons[i][j].contenu == nombre)
                    if(nombre == '4')
                        if((i-1 == -1 && j-1 == -1) || (i-1 == -1 && j+1 == @nbColonnes) || (i+1 == @nbLignes && j-1 == -1) || (i+1 == @nbLignes && j+1 == @nbColonnes))
                            possible = true
                        else
                            possible = false
                        end
                    end

                    if(nombre == '6')
                        if(i-1 == -1 || i+1 == @nbLignes || j-1 == -1 || j+1 == @nbColonnes)
                            possible = true
                        else
                            possible = false
                        end
                    end

                    if(possible == true)
                        if(coordValide(i-1, j-1))
                            @boutons[i-1][j-1].couleur= couleur
                            @boutons[i-1][j-1].updateCouleur(@css.cssW, @css.cssB, @css.cssG)
                        end
                        if(coordValide(i-1, j))
                            @boutons[i-1][j].couleur= couleur
                            @boutons[i-1][j].updateCouleur(@css.cssW, @css.cssB, @css.cssG)
                        end
                        if(coordValide(i-1, j+1))
                            @boutons[i-1][j+1].couleur= couleur
                            @boutons[i-1][j+1].updateCouleur(@css.cssW, @css.cssB, @css.cssG)
                        end
                        if(coordValide(i, j-1))
                            @boutons[i][j-1].couleur= couleur
                            @boutons[i][j-1].updateCouleur(@css.cssW, @css.cssB, @css.cssG)
                        end
                        if(coordValide(i, j))
                            @boutons[i][j].couleur= couleur
                            @boutons[i][j].updateCouleur(@css.cssW, @css.cssB, @css.cssG)
                        end
                        if(coordValide(i, j+1))
                            @boutons[i][j+1].couleur= couleur
                            @boutons[i][j+1].updateCouleur(@css.cssW, @css.cssB, @css.cssG)
                        end
                        if(coordValide(i+1, j-1))
                            @boutons[i+1][j-1].couleur= couleur
                            @boutons[i+1][j-1].updateCouleur(@css.cssW, @css.cssB, @css.cssG)
                        end
                        if(coordValide(i+1, j))
                            @boutons[i+1][j].couleur= couleur
                            @boutons[i+1][j].updateCouleur(@css.cssW, @css.cssB, @css.cssG)
                        end
                        if(coordValide(i+1, j+1))
                            @boutons[i+1][j+1].couleur= couleur
                            @boutons[i+1][j+1].updateCouleur(@css.cssW, @css.cssB, @css.cssG)
                        end
                    end
                end
            end
        end
        return self
    end

    ##
    # Retourne vrai si les coordonnées passées en paramètre sont valides (ne sortent pas du tableau)
    ##
    # * +i+ Coordonnée en abscisse
    # * +j+ Coordonnée en ordonnée
    def coordValide(i, j)
        if(i>=0 && i<@nbLignes && j>=0 && j<@nbColonnes)
            return true;
        end
        return false
    end

    ##
    #   Méthode qui change la valeur du boolean @redSquare 
    def activeRedSquare()
        if(@redSquare == false)
            @redSquare = true
        else
            @redSquare = false
        end
    end

    ##
    #   Méthode qui ajoute un css avec bordure rouge au bouton en paramètre selon sa couleur de base
    #   Cette méthode est appelée lorsque l'utilisateur a activé l'aide RedSquare et que sa souris survole un boutton
    ##
    # * +boutton+   Le bouton du carré
    def putRedSquare(boutton)
        if(boutton.couleur=="white")
            boutton.boutton.style_context.add_provider(@css.cssWRedBorder, Gtk::StyleProvider::PRIORITY_USER)
        elsif(boutton.couleur=="black")
            boutton.boutton.style_context.add_provider(@css.cssBRedBorder, Gtk::StyleProvider::PRIORITY_USER)
        else    
            boutton.boutton.style_context.add_provider(@css.cssGRedBorder, Gtk::StyleProvider::PRIORITY_USER)
        end
        return self
    end

    ##
    #   Méthode qui enlève un css avec bordure rouge au bouton en paramètre selon sa couleur de base
    #   Cette méthode est appelée lorsque l'utilisateur a activé l'aide RedSquare
    #   et que sa souris quitte un boutton
    ##
    # * +boutton+   Le bouton du carré
    def removeRedSquare(boutton)
        if(boutton.couleur=="white")
            boutton.boutton.style_context.add_provider(@css.cssW, Gtk::StyleProvider::PRIORITY_USER)
        elsif(boutton.couleur=="black")
            boutton.boutton.style_context.add_provider(@css.cssB, Gtk::StyleProvider::PRIORITY_USER)
        else
            boutton.boutton.style_context.add_provider(@css.cssG, Gtk::StyleProvider::PRIORITY_USER)
        end
        return self
    end

    ##
    #   Méthode qui appelle la méthode putRedSquare sur les 8 boutons valides 
    #   entourant le bouton sur lequel la souris de l'utilisateur se trouve
    #   
    ##
    # * +i+     coordonnées abscisse
    # * +j+     coordonnées ordonnée
    def enterButton(i, j)
        if(@redSquare)
            if(coordValide(i-1, j-1))
                putRedSquare(@boutons[i-1][j-1])
            end
            if(coordValide(i-1, j))
                putRedSquare(@boutons[i-1][j])
            end
            if(coordValide(i-1, j+1))
                putRedSquare(@boutons[i-1][j+1])
            end
            if(coordValide(i, j-1))
                putRedSquare(@boutons[i][j-1])
            end
            if(coordValide(i, j))
                putRedSquare(@boutons[i][j])
            end
            if(coordValide(i, j+1))
                putRedSquare(@boutons[i][j+1])
            end
            if(coordValide(i+1, j-1))
                putRedSquare(@boutons[i+1][j-1])
            end
            if(coordValide(i+1, j))
                putRedSquare(@boutons[i+1][j])
            end
            if(coordValide(i+1, j+1))
                putRedSquare(@boutons[i+1][j+1])
            end
        end
        return self
    end

    ##
    #   Méthode qui appelle la méthode removeRedSquare sur les 8 boutons valides 
    #   entourant le bouton sur lequelle la souris de l'utilisateur se trouvait
    #   (méthode appelée lorsque l'utilisateur quitte un bouton avec sa souris
    #   et que l'aide RedSquare est activée)
    #   
    ##
    # * +i+     coordonnées abscisse
    # * +j+     coordonnées ordonnée
    def leaveButton(i, j)
        if(@redSquare)
            if(coordValide(i-1, j-1))
                removeRedSquare(@boutons[i-1][j-1])
            end
            if(coordValide(i-1, j))
                removeRedSquare(@boutons[i-1][j])
            end
            if(coordValide(i-1, j+1))
                removeRedSquare(@boutons[i-1][j+1])
            end
            if(coordValide(i, j-1))
                removeRedSquare(@boutons[i][j-1])
            end
            if(coordValide(i, j))
                removeRedSquare(@boutons[i][j])
            end
            if(coordValide(i, j+1))
                removeRedSquare(@boutons[i][j+1])
            end
            if(coordValide(i+1, j-1))
                removeRedSquare(@boutons[i+1][j-1])
            end
            if(coordValide(i+1, j))
                removeRedSquare(@boutons[i+1][j])
            end
            if(coordValide(i+1, j+1))
                removeRedSquare(@boutons[i+1][j+1])
            end
        end
        return self
    end

    ##
    # Cette méthode sauvegarde la progression de l'utilisateur sur cette grille
    ##
    # * +chrono+ le temps passé sur la grille
    # * +modeJeu+ le mode de jeu sur lequel se trouve l'utilisateur
    def sauveProgression(chrono, modeJeu)
        nomSauvegarde = ($userPath+modeJeu+'/'+@nomGrille.split("/")[2]).delete_suffix(".txt")
        data = Array.new

        #Ecriture d'un tableau sérializé dans un fichier
        #L'indice 0 contient de tableau @joues (le tableau des coups joués)
        #L'indice 1 et 2 contiennent respectivement les minutes et les secondes du chrono (temps passé sur la grille)
        #L'indice 3 est le boolean qui indique si l'utilisateur a demandé l'aide du remplissage auto
        data[0] = @joues
        data[1] = chrono.minutes
        data[2] = chrono.secondes
        data[3] = chrono.penaliteMin
        data[4] = chrono.penaliteSec
        data[5] = @boolFillNine
        
        File.open(nomSauvegarde, 'w')
        File.chmod(0777, nomSauvegarde)
        File.binwrite(nomSauvegarde, Marshal.dump(data))
        
        return self
    end

    ##
    # Méthode qui va jouer le prochain coup logique du joueur
    def nextMove()
        0.upto(@nbLignes-1) do |i|
            0.upto(@nbColonnes-1) do |j|
                if(@boutons[i][j].contenu != ' ')
                    nbNoir = 0
                    nbGris = 0
                    for x in -1..1
                        for y in -1..1
                            if(coordValide(i+x, j+y) && @boutons[i+x][j+y].couleur == "black")
                                nbNoir += 1
                            end

                            if(coordValide(i+x, j+y) && @boutons[i+x][j+y].couleur == "grey")
                                nbGris += 1
                            end

                            if((nbGris == 9 - @boutons[i][j].contenu.to_i) || ((!coordValide(i-1, j) || !coordValide(i+1, j) || !coordValide(i, j-1) || !coordValide(i, j+1)) &&nbGris == 6 - @boutons[i][j].contenu.to_i ))
                                for a in -1..1
                                    for b in -1..1
                                        if(coordValide(i+a, j+b) && @boutons[i+a][j+b].couleur == "white" && @ligne_solution[(i+a) * @nbLignes + (j+b)].to_i == 1)
                                            @joues.push(Coup_joue.creer(i+a, j+b, "white"))
                                            @boutons[i+a][j+b].change_couleur(@css.cssW, @css.cssB, @css.cssG)
                                            return true
                                        end
                                    end
                                end
                            end
    
                            if(nbNoir == @boutons[i][j].contenu.to_i)
                                for a in -1..1
                                    for b in -1..1
                                        if(coordValide(i+a, j+b) && @boutons[i+a][j+b].couleur == "white" && @ligne_solution[(i+a) * @nbLignes + (j+b)].to_i == 0)
                                            @joues.push(Coup_joue.creer(i+a, j+b, "white"))
                                            @boutons[i+a][j+b].change_couleur(@css.cssW, @css.cssB, @css.cssG)
                                            @joues.push(Coup_joue.creer(i+a, j+b, "black"))
                                            @boutons[i+a][j+b].change_couleur(@css.cssW, @css.cssB, @css.cssG)
                                            return true
                                        end
                                    end
                                end
                            end
                        end
                    end
                    if(coordValide(i, j) && @boutons[i][j].contenu == '5' && coordValide(i-1, j) && @boutons[i-1][j].contenu == '8')
                        for a in -1..1
                            if(coordValide(i+1, j+a) && @boutons[i+1][j+a].couleur == "white" && @ligne_solution[(i+1) * @nbLignes + (j+a)].to_i == 0)
                                @joues.push(Coup_joue.creer(i+1, j+a, "white"))
                                @boutons[i+1][j+a].change_couleur(@css.cssW, @css.cssB, @css.cssG)
                                @joues.push(Coup_joue.creer(i+1, j+a, "black"))
                                @boutons[i+1][j+a].change_couleur(@css.cssW, @css.cssB, @css.cssG)
                                return true
                            end
                        end
                    end

                    if(coordValide(i, j) && @boutons[i][j].contenu == '5' && coordValide(i, j-1) && @boutons[i][j-1].contenu == '8')
                        for a in -1..1
                            if(coordValide(i+a, j+1) && @boutons[i+a][j+1].couleur == "white" && @ligne_solution[(i+a) * @nbLignes + (j+1)].to_i == 0)
                                @joues.push(Coup_joue.creer(i+a, j+1, "white"))
                                @boutons[i+a][j+1].change_couleur(@css.cssW, @css.cssB, @css.cssG)
                                @joues.push(Coup_joue.creer(i+a, j+1, "black"))
                                @boutons[i+a][j+1].change_couleur(@css.cssW, @css.cssB, @css.cssG)
                                return true
                            end
                        end
                    end

                    if(coordValide(i, j) && @boutons[i][j].contenu == '2' && coordValide(i-2, j) && @boutons[i-2][j].contenu == '8')
                        for a in 0..1
                            for b in -1..1
                                if(coordValide(i+a, j+b) && @boutons[i+a][j+b].couleur == "white" && @ligne_solution[(i+a) * @nbLignes + (j+b)].to_i == 0)
                                    @joues.push(Coup_joue.creer(i+a, j+b, "white"))
                                    @boutons[i+a][j+b].change_couleur(@css.cssW, @css.cssB, @css.cssG)
                                    @joues.push(Coup_joue.creer(i+a, j+b, "black"))
                                    @boutons[i+a][j+b].change_couleur(@css.cssW, @css.cssB, @css.cssG)
                                    return true
                                end
                            end
                        end
                    end

                    if(coordValide(i, j) && @boutons[i][j].contenu == '3' && coordValide(i-1, j-1) && @boutons[i-1][j-1].contenu == '8')
                        for a in -1..1
                            if(coordValide(i+1, j+a) && @boutons[i+1][j+a].couleur == "white" && @ligne_solution[(i+1) * @nbLignes + (j+a)].to_i == 0)
                                @joues.push(Coup_joue.creer(i+1, j+a, "white"))
                                @boutons[i+1][j+a].change_couleur(@css.cssW, @css.cssB, @css.cssG)
                                @joues.push(Coup_joue.creer(i+1, j+a, "black"))
                                @boutons[i+1][j+a].change_couleur(@css.cssW, @css.cssB, @css.cssG)
                                return true
                            end
                        end
                        if(coordValide(i-1, j+1) && @boutons[i-1][j+1].couleur == "white" && @ligne_solution[(i-1) * @nbLignes + (j+1)].to_i == 0)
                            @joues.push(Coup_joue.creer(i-1, j+1, "white"))
                            @boutons[i-1][j+1].change_couleur(@css.cssW, @css.cssB, @css.cssG)
                            @joues.push(Coup_joue.creer(i-1, j+1, "black"))
                            @boutons[i-1][j+1].change_couleur(@css.cssW, @css.cssB, @css.cssG)
                            return true
                        end
                        if(coordValide(i, j+1) && @boutons[i][j+1].couleur == "white" && @ligne_solution[(i) * @nbLignes + (j+1)].to_i == 0)
                            @joues.push(Coup_joue.creer(i, j+1, "white"))
                            @boutons[i][j+1].change_couleur(@css.cssW, @css.cssB, @css.cssG)
                            @joues.push(Coup_joue.creer(i, j+1, "black"))
                            @boutons[i][j+1].change_couleur(@css.cssW, @css.cssB, @css.cssG)
                            return true
                        end
                    end
                end
            end
        end
        return false
    end

end