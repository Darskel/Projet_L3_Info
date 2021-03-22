class Classement
    def Classement.creer(win)
        new(win)
    end

    def initialize(win)
        #Création de l'interface

        @window = win
        @box = Gtk::Fixed.new()
        @boiteInterieure = Gtk::Box.new()
        
    end
end