##
# Classe qui permet d'effectuer un chronometre a l'aide d'un thread
##
# * +thr+       Le thread utilisé
# * +minutes+   Les minutes écoulées depuis le début du niveau
# * +secondes+  Les secondes écoulées depuis le début du niveau
class Chronometre

    ##
    # Constructeur
    ##
    # * +label+     Le Gtk::Label qui accueil le temps
    # * +prevMin+   Les minutes déjà passées dans le jeu
    # * +prevSec+   Les secondes déjà passées dans le jeu
    def Chronometre.creer(label, prevMin, prevSec)
        new(label, prevMin, prevSec)
    end

    private_class_method :new

    attr_reader :thr, :minutes, :secondes

    ##
    # Création de l'objet
    ##
    # * +label+     Le Gtk::Label qui accueil le temps
    # * +prevMin+   Les minutes déjà passées dans le jeu
    # * +prevSec+   Les secondes déjà passées dans le jeu
    def initialize(label, prevMin, prevSec)
        depart = Time.now

        @minutes = prevMin
        @secondes = prevSec

        label.text = "Temps : 0:00"

        @thr = Thread.new{
            while(true)
                courant = Time.now - depart

                if courant >= 60
                    @minutes = courant.to_i / 60
                    @secondes = courant.to_i % 60
                else
                    @minutes = 0
                    @secondes = courant.to_i
                end
                label.text = "Temps : "+@minutes.to_s + ":"+@secondes.to_s
                sleep(1)
            end
        }
    end
end