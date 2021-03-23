class Classement
    def Classement.creer(win)
        new(win)
    end

    def initialize(win)
        #Création de l'interface

        @window = win
        @box = Gtk::Fixed.new()
        @boiteInterieure = Gtk::Box.new(:horizontal)
        @indexChapitre = 1
        @titreChapitre = Gtk::Label.new()
        @titreChapitre.set_text("Chapitre "+ @indexChapitre.to_s())
        @boxClassement = Gtk::Box.new(:horizontal)
        @texteClassement = Gtk::Label.new()
        @boutonFlecheSuivant = Gtk::Button.new()
        @boutonFlechePrecedent = Gtk::Button.new()
        @boutonMenu = Gtk::Button.new()

        @box.add(Gtk::Image.new(:file => "../maquettes/classement.png"))

        cssChapitre = ajouteTexte(3)
        cssTexteClassement = ajouteTexte(2)
        ajouteTexteProvider(@titreChapitre,cssChapitre)
        ajouteTexteProvider(@texteClassement,cssTexteClassement)
        
        ajouteBouton(@box,@boutonMenu,2,55,45,(1200 *0.015),675 * 0.025,nil,@window,@boiteInterieure)
        @box.put(@titreChapitre,(1200 *0.4), 675 * 0.24)
        @box.add(@boiteInterieure)
        @window.add(@box)
        @window.show_all
    end
end