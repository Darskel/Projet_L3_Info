##
# Classe qui permet d'effectuer un chronometre a l'aide d'un thread
##
# * +thr+       Le thread utilisé
# * +minutes+   Les minutes écoulées depuis le début du niveau
# * +secondes+  Les secondes écoulées depuis le début du niveau
# * +labelPenalite+     Le Gtk::Label qui accueil les pénalité
# * +penaliteMin+  somme des pénalités en minutes reçue par le joueur
# * +penaliteSec+  somme des pénalités en secondes reçue par le joueur
# * +label+         Le label affichant le temps total
class Chronometre

    ##
    # Constructeur
    ##
    # * +label+             Le Gtk::Label qui accueil le temps
    # * +labelPenalite+     Le Gtk::Label qui accueil les pénalité
    def Chronometre.creer(label, labelPenalite)
        new(label, labelPenalite)
    end

    private_class_method :new

    attr_reader :thr, :penaliteMin, :penaliteSec

    attr_accessor :minutes, :secondes

    ##
    # Création de l'objet
    ##
    # * +label+             Le Gtk::Label qui accueil le temps
    # * +labelPenalite+     Le Gtk::Label qui accueil les pénalité
    def initialize(label, labelPenalite)
        @label = label
        @minutes
        @secondes
        @penaliteMin
        @penaliteSec
        @labelPenalite = labelPenalite
        
        css = Gtk::CssProvider.new

        css.load(data: <<-CSS)
        label {
            font-size : 25px;
        }
        CSS

        @label.style_context.add_provider(css, Gtk::StyleProvider::PRIORITY_USER)
        @labelPenalite.style_context.add_provider(css, Gtk::StyleProvider::PRIORITY_USER)
    end

    ##
    # Déclaration de la méthode lancer
    # Prends en paramètres deux entiers, 
    # * +minutes+
    # * +secondes+
    # * +penaliteMin+  somme des pénalités en minutes reçue par le joueur
    # * +penaliteSec+  somme des pénalités en secondes reçue par le joueur
    # représentants respectivement les minutes et secondes au départ du chronomètre
    def lancer(minutes, secondes, penaliteMin, penaliteSec)
        @penaliteMin = penaliteMin
        @penaliteSec = penaliteSec
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

                penaliteMinutesAffiche = (@penaliteMin < 10) ? "0#{@penaliteMin}" : "#{@penaliteMin}"
                penaliteSecondesAffiche = (@penaliteSec < 10) ? "0#{@penaliteSec}" : "#{@penaliteSec}"

                if @secondes >= 59
                    @minutes += 1
                    @secondes = 0
                else
                    @secondes += 1
                end

                @label.text = minutesAffiche + " : "+secondesAffiche
                @labelPenalite.text = penaliteMinutesAffiche + " : "+penaliteSecondesAffiche
                sleep(1)
            end
        }
        return self
    end

    ##
    # Termine le Thread qui gère le chronomètre pour stopper l'avancer du temps
    def kill()
        Thread.kill(@thr)
        return self
    end

    ##
    # Incrémente les secondes du temps donné
    ##
    # * +temps+     le temps en secondes à ajouter au chrono
    def augmenteTemps(temps)
        @secondes += temps
        @penaliteSec += temps
        if(@secondes >= 59)
            @minutes += @secondes / 60
            @secondes = @secondes %60
        end

        if @penaliteSec >= 59
            @penaliteMin += @penaliteSec / 60
            @penaliteSec = @penaliteSec % 60
        end
        return self
    end

    
end