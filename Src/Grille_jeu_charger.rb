##
#   Déclaration de la classe Grille_jeu_charger qui est une sous classe de Grille_jeu
#
class Grille_jeu_charger < Grille_jeu
    
    private_class_method :new
    ##
    #   Déclaration de la méthode creer qui renvoie vers la méthode new
    def Grille_jeu_charger.creer(estJouable, joues, map, chrono, modeJeu)
        new(estJouable, joues, map, chrono, modeJeu)
    end

    attr_reader :nomSauvegarde

    ##
    #   Constructeur de Grille_jeu_charger
    #Constructeur sensiblement identique au constructeur de Grille_jeu
    #Deux variables en plus : 
    # * +chrono+    le chrono qui sera lancé avec le temps précédemment sauvegardé
    #               selon la grille et le type de jeu
    # * +modeJeu+   Le mode de jeu que l'on veut charger pour la grille donnée
    #               (soit 'Libre' ou 'Aventure')
    def initialize(estJouable, joues, map, chrono, modeJeu)
        #Appel du constructeur de la classe mère
        super(estJouable, joues, map)

        #Recherche du nom du fichier à charger
        nomSauvegarde = ($userPath+modeJeu+'/'+map.split("/")[2]).delete_suffix(".txt")
        data = Array.new

        #On charge les données sauvegardées dans un tableau
        # - L'indice 0 du tableau contient le tableau de coups joués lors de la sauvegarde
        # - L'indice 1 et 2 contiennent respectivement
        #les minutes et secondes du chronomètre au moment de la sauvegarde
        # - L'indice 3 est le boolean qui indique si l'utilisateur avait 
        #demandé l'aide du remplissage auto

        File.open(nomSauvegarde, "r") {|f| data = Marshal::load(f)}

        @joues.concat(data[0])
        @joues.each{|coup|
            @bouttons[coup.indiceI][coup.indiceJ].change_couleur(@css.cssW, @css.cssB, @css.cssG)
        }

        @boolFillNine = data[5]

        #Si l'utilisateur avait utilisé l'aide remplissage, on la réactive
        if(@boolFillNine)
            fillNine('0')
            fillNine('4')
            fillNine('6')
            fillNine('9')
        end
            
        
        #On demande au chrono de se relancer avec le temps chargé
        chrono.lancer(data[1], data[2], data[3] , data[4])
    end

    ##
    # Déclaration de la méthode statique exist?
    # deux paramètres : 
    # * +map+ le nom de la grille
    # * +modeJeu+ le mode de jeu ('Libre'/'Aventure')
    # cette méthode return true si une sauvegarde existe 
    # pour un mode de jeu et une grille donnée
    def Grille_jeu_charger.exist?(map, modeJeu)
        nomSauvegarde = ($userPath+modeJeu+'/'+map.split("/")[2]).delete_suffix(".txt")

        return File.exist?(nomSauvegarde)
    end
end

