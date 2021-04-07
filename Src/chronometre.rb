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
    def Chronometre.creer(label)
        new(label)
    end

    private_class_method :new

    attr_reader :thr, :minutes, :secondes

    attr_accessor :minutes, :secondes

    ##
    # Création de l'objet
    ##
    # * +label+     Le Gtk::Label qui accueil le temps
    # * +minutes+   Les minutes du chronomètre
    # * +secondes+   Les secondes du chronomètre
    def initialize(label)
        @label = label
        @minutes = Integer.new
        @secondes = Integer.new        
    end

    ##
    # Déclaration de la méthode lancer
    # Prends en paramètres deux entiers, 
    # * +minutes+
    # * +secondes+
    # représentants respectivement les minutes et secondes au départ du chronomètre
    def lancer(minutes, secondes)
        @minutes = minutes
        @secondes = secondes
        # La méthode lance un thread qui incrémente 
        # chaque seconde la variable d'instance @secondes et les minutes toutes les 60 secondes etc...
        @thr = Thread.new{
            while(true)
                # Le chronomètre est affiché à l'aide de deux variables secondesAffiche et minutesAffiche
                # qui rajoute un '0' devant les minutes et/ou les secondes 
                # si ces dernières sont inférieures à 10
                minutesAffiche = (@minutes < 10) ? "0#{@minutes}" : "#{@minutes}"
                secondesAffiche = (@secondes < 10) ? "0#{@secondes}" : "#{@secondes}"

                if @secondes >= 59
                    @minutes += 1
                    @secondes = 0
                else
                    @secondes += 1
                end
                
                @label.text = minutesAffiche + " : "+secondesAffiche
                sleep(1)
            end
        }
    end

    ##
    # Termine le Thread qui gère le chronomètre pour stopper l'avancer du temps
    def kill()
        Thread.kill(@thr)
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