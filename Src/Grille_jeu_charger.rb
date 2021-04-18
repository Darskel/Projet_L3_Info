##
#   Hérite de Grille jeu, permet de charger une sauvegarde
##
# * +data+      Les éléments dans le fichier de la sauvegarde
class Grille_jeu_charger < Grille_jeu
    
    private_class_method :new
    ##
    #   Déclaration de la méthode creer qui renvoie vers la méthode new
    ##
    # * +estJouable+    boolean pour savoir si la grille doit être cliquable
    # * +joues+         tableau des coups joués
    # * +map+           nom de la grille à charger
    # * +chron+         instance du chronomètre
    # * +modeJeu+       nom du mode de jeu
    def Grille_jeu_charger.creer(estJouable, joues, map, chrono, modeJeu)
        new(estJouable, joues, map, chrono, modeJeu)
    end

    attr_reader :nomSauvegarde

    ##
    #   Constructeur de Grille_jeu_charger
    #Constructeur sensiblement identique au constructeur de Grille_jeu
    ##
    # * +estJouable+    boolean pour savoir si la grille doit être cliquable
    # * +joues+         tableau des coups joués
    # * +map+           nom de la grille à charger
    # * +chron+         instance du chronomètre
    # * +modeJeu+       nom du mode de jeu
    def initialize(estJouable, joues, map, chrono, modeJeu)
        #Appel du constructeur de la classe mère
        super(estJouable, joues, map)

        #Recherche du nom du fichier à charger
        nomSauvegarde = ($userPath+modeJeu+'/'+map.split("/")[2]).delete_suffix(".txt")
        @data = Array.new

        #On charge les données sauvegardées dans un tableau
        # - L'indice 0 du tableau contient le tableau de coups joués lors de la sauvegarde
        # - L'indice 1 et 2 contiennent respectivement
        #les minutes et secondes du chronomètre au moment de la sauvegarde
        # - L'indice 3 est le boolean qui indique si l'utilisateur avait 
        #demandé l'aide du remplissage auto

        @data = Marshal.load(File.binread(nomSauvegarde))

        if (@joues != nil)
            @joues.concat(@data[0])
            @joues.each{|coup|
                @bouttons[coup.indiceI][coup.indiceJ].change_couleur(@css.cssW, @css.cssB, @css.cssG)
            }
        end

        boolFillNine = @data[5]

        #Si l'utilisateur avait utilisé l'aide remplissage, on la réactive
        if(boolFillNine)
            fillNine('0')
            fillNine('4')
            fillNine('6')
            fillNine('9')
        end
            
        
        #On demande au chrono de se relancer avec le temps chargé
        if (chrono != nil)
            chrono.lancer(@data[1], @data[2], @data[3] , @data[4])
        end
    end

    ##
    # Déclaration de la méthode statique exist?
    # cette méthode return true si une sauvegarde existe 
    # pour un mode de jeu et une grille donnée
    ##
    # * +map+ le nom de la grille
    # * +modeJeu+ le mode de jeu ('Libre'/'Aventure')
    def Grille_jeu_charger.exist?(map, modeJeu)
        nomSauvegarde = ($userPath+modeJeu+'/'+map.split("/")[2]).delete_suffix(".txt")

        return File.exist?(nomSauvegarde)
    end

    ##
    # Permet d'obtenir le temps de la Grille sur la sauvegarde du joueur
    ##
    # * return String du temps (m + s)
    def getChrono()
        return @data[1].to_s + "' " + @data[2].to_s + "''"
    end

    ##
    # Permet d'obtenir le temps des pénalités de la Grille sur la sauvegarde du joueur
    ##
    # * return String du temps (m + s)
    def getPenalites()
        return @data[3].to_s + "' " + @data[4].to_s + "''"
    end
end

