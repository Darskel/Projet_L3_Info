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

    attr_accessor :minutes, :secondes

    ##
    # Création de l'objet
    ##
    # * +label+     Le Gtk::Label qui accueil le temps
    # * +prevMin+   Les minutes déjà passées dans le jeu
    # * +prevSec+   Les secondes déjà passées dans le jeu
    def initialize(label, prevMin, prevSec)
       
        @minutes = prevMin
        @secondes = prevSec

        label.text = "Temps : 0:00"

        @thr = Thread.new{
            while(true)

                if @secondes >= 59
                    @minutes += 1
                    @secondes = 0
                else
                    @secondes += 1
                end
                label.text = @minutes.to_s + " : "+@secondes.to_s
                sleep(1)
                label.text = "Temps : "+@minutes.to_s + ":"+@secondes.to_s
            end
        }
    end

    ##
    # Incrémente les secondes du temps donné
    ##
    # * +temps+     le temps en secondes à ajouter au chrono
    def augmenteTemps(temps)
        @secondes += temps
        if(@secondes >= 59)
            @minutes += @secondes / 60
            @secondes = @secondes %60
        end
    end
end