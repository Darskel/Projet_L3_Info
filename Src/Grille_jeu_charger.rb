class Grille_jeu_charger < Grille_jeu
    
    def Grille_jeu_charger.creer(estJouable, joues, map, chrono, typeJeu)
        new(estJouable, joues, map, chrono, typeJeu)
    end

    def initialize(estJouable, joues, map, chrono, typeJeu)
        super(estJouable, joues, map)

        nomSauvegarde = ($userPath+typeJeu+'/'+map.split("/")[2]).delete_suffix(".txt")
        data = Array.new

        File.open(nomSauvegarde, "r") {|f| data = Marshal::load(f)}

        @joues.concat(data[0])
        @joues.each{|coup|
            @bouttons[coup.indiceI][coup.indiceJ].change_couleur(@css.cssW, @css.cssB, @css.cssG)
        }
        
        chrono.lancer(data[1], data[2])
    end

    def Grille_jeu_charger.exist?(map, typeJeu)
        nomSauvegarde = ($userPath+typeJeu+'/'+map.split("/")[2]).delete_suffix(".txt")

        return File.exist?(nomSauvegarde)
    end
end

