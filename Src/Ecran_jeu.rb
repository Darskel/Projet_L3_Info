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
    # * +map+       le nom de la map utilisée
    # * +mode+      Le mode de jeu en cours
    def Ecran_jeu.creer(win, map, mode)
        new(win, map, mode)
    end

    ##
    # Construction de l'instance
    ##
    # * +win+       Fenetre graphique de l'application
    # * +map+       le nom de la map utilisée
    # * +mode+      Le mode de jeu en cours
    def initialize(win, map, mode)
        #Création de l'interface 
        @window = win
        @mode = mode
        @box = Gtk::Fixed.new()
        @box2 = Gtk::Box.new(:horizontal)
        @retourLibre = Gtk::Button.new()
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
        ajouteBouton(@box,@retourLibre,1,55,45,(1200 *0.015), 675 * 0.025,method(:vers_libre),@window,@box2)
        ajouteBouton(@box,@boutonCoupLogique,1,60,60,(1200*0.899), 675*0.015,nil,@window,@box2)
        ajouteBouton(@box,@boutonCheck,1,60,60,(1200*0.855), 675*0.015,nil,@window,@box2)
        ajouteBouton(@box,@boutonCurseur,1,60,60,(1200*0.812), 675*0.015,nil,@window,@box2)
        ajouteBouton(@box,@boutonUndo,1,60,60,(1200*0.767), 675*0.015,nil,@window,@box2)
        ajouteBouton(@box,@boutonRemplissage,1,60,60,(1200*0.942), 675*0.015,nil,@window,@box2)
        @box.put(temps,450,630)

        #lance une grille vierge de coups si aucune sauvegarde existe 
        #concernant la map et le mode voulu
        if(Grille_jeu_charger.exist?(map, "Libre"))
            @grille = Grille_jeu_charger.creer(true, joues, map, chrono, @mode)
        else
            @grille = Grille_jeu.creer(true, joues, map)
            chrono.lancer(0,0)
        end

        
        #Sauvegarde la grille quand on la quitte et arrête le chrono
        @retourLibre.signal_connect("clicked"){
            @grille.sauveProgression(chrono, @mode)
            chrono.kill
        }
        #signal pour activer le rectangle rouge autour du curseur
        @boutonCurseur.signal_connect("clicked"){
            @grille.activeRedSquare()
        }

        #signal qui remplit les cases faciles (9, 0, 4, 6)
        @boutonRemplissage.signal_connect("clicked"){
            if(!@grille.boolFillNine)
                @grille.fillNine('9')
                @grille.fillNine('4')
                @grille.fillNine('6')
                @grille.fillNine('0')
            end
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
                ecran_victoire(chrono,map)
            else
                if(fini[1] == true)
                    chrono.augmenteTemps(30)
                end
            end
        }

        #Signal du prochain coup logique
        @boutonCoupLogique.signal_connect("clicked"){
            verif = @grille.check()
            if(verif[0] == false && verif[1] == false)
                @grille.nextMove()
                chrono.augmenteTemps(30)
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
    def ecran_victoire(chrono, map)
        @box2.remove(@box)

        ligne = map[map.length - 5].to_i

        res =  lectureSucces(ligne - 1,chrono)
        
        begin
            File.delete(@grille.nomSauvegarde)
        rescue Errno::ENOENT
        end

        box = Gtk::Fixed.new()

        duree = "Votre temps : " + chrono.minutes.to_s + ":" + chrono.secondes.to_s

        @box2.add(box)

        box.add(Gtk::Image.new(:file => "../maquettes/niveauFini.png"))

        css = ajouteCss(2)
        cssTemps = Gtk::CssProvider.new

        cssTemps.load(data: <<-CSS)
            label {
                font-size : 40px;
            }
            CSS

        buttonMenu = Gtk::Button.new(:label => "")
        temps = Gtk::Label.new(duree)

        if res == "false" && @mode == "Libre"
            succes = Gtk::Label.new("Vous avez remporté un succès !")
            ajoutecssProvider(succes, cssTemps, 200,200)   
            box.put(succes, (1200 *0.45), 675 * 0.60) 
        end

        ajoutecssProvider(buttonMenu, css, 290,72)
        ajoutecssProvider(temps, cssTemps, 200,200)

        box.put(buttonMenu, (1200 *0.74), 675 * 0.87)
        box.put(temps, (1200 *0.52), 675 * 0.45)

        buttonMenu.signal_connect("clicked"){
            vers_menu(@window, @box2)
        }

        @window.show_all
        return self
    end


    ##
    # On regarde si le joueur à déjà le succès, si non on lui ajoute
    ##
    # * +ligne+     La ligne a regardé dans le fichier
    def lectureSucces(ligne, chrono)
        file = File.open($userPath + "succes.txt")
        file_data = file.readlines.map(&:chomp)

        ligneFich = file_data[ligne].split(" ")

        if ligneFich[1].to_i >= chrono.minutes && @mode == "Libre"
            if ligneFich[2].to_i > chrono.secondes && ligneFich[1].to_i == chrono.minutes
                ligneFich[2] = chrono.secondes.to_s
            elsif ligneFich[2].to_i < chrono.secondes && ligneFich[1].to_i == chrono.minutes
                i = 0
            else
                ligneFich[2] = chrono.secondes.to_s
                ligneFich[1] = chrono.minutes.to_s
            end
            enregirstreScore(file_data, ligne,ligneFich)
        end

        res = ligneFich[0]

        if res == "false" && @mode == "Aventure"
            ligneFich[0] = "true"
            enregirstreScore(file_data, ligne,ligneFich)
        end
        return res
    end

    ##
    # Enregistre les informations de la parties dans le fichier succes du joueur
    ##
    # * +file_data+     Toutes les données du fichier
    # * +ligne+         numéro de la ligne a modifier
    # * +ligneFich+     la ligne modifiée
    def enregirstreScore(file_data, ligne, ligneFich)
        file_data[ligne] = ligneFich.join(" ")
        i = 0
        while i <  file_data.length
            file_data[i] = file_data[i] + "\n"
            i += 1
        end
        File.open($userPath + "succes.txt", "w"){ |f|
            f.write(file_data.join())
        }
    end
end