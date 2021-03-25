require "./Grille.rb"
require "./Historique.rb"

class Quicksave

private_class_method:new

#  Cette Quicksave enregistre l'etat de la grille et l'historique des actions qui sont pass� en parametre

  def Quicksave.nouveau(plateau, ha)
    new(plateau, ha)
  end

  def initialize ( plateau, ha )

        @plateau = plateau

        tailleX = plateau.size()
        tailleY = plateau[0].size()

        @savePlateau = Array.new( ( 4 + 3 * (tailleX - 1 )) + ( (3 + 2 * ( tailleX - 1 )) * ( tailleY - 1 )), nil)

        0.upto( tailleX - 1 ) { |i|
            @savePlateau[i] = Array.new( tailleY, nil)
        }



        @saveHistorique = Historique.new()
        savePos = ha.getPos()

        begin
            while ( true ) do
                ha.undo()
            end
        rescue EmptyHistoriqueError => e
            # on boucle jusqu'a ce que l'historique soit vide
        end

        @saveHistorique.setPos( savePos)
        ha.setPos( savePos)
    end


end
