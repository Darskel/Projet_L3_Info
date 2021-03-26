load "Utils.rb"

class Classement
    def Classement.creer(win)
        new(win)
    end

    def initialize(win)
        #Création de l'interface

        @window = win
        @box = Gtk::Fixed.new()
        @boiteInterieure = Gtk::Box.new(:horizontal)
        indexChapitre = 1
        @titreChapitre = Gtk::Label.new()
        @titreChapitre.set_text("Chapitre "+indexChapitre.to_s()+" : Hawaï")
        @boxClassement = Gtk::Box.new(:horizontal)
        @texteClassement = Gtk::Label.new()
        @boutonFlecheSuivant = Gtk::Button.new()
        @boutonFlechePrecedent = Gtk::Button.new()  
        @boutonMenu = Gtk::Button.new()

        classementChap1 = ["Arthur","Tom","Alexis"]
        classementChap2 = ["Tom","Arthur","Alexis"]
        classementChap3 = ["Alexis","Arthur","Tom"]

        @box.add(Gtk::Image.new(:file => "../maquettes/classement.png"))

        cssChapitre = ajouteTexte(3)
        cssTexteClassement = ajouteTexte(2)
        ajouteTexteProvider(@titreChapitre,cssChapitre)
        ajouteTexteProvider(@texteClassement,cssTexteClassement)
        
        ajouteBouton(@box,@boutonMenu,1,55,45,(1200 *0.015),675 * 0.025,nil,@window,@boiteInterieure)
        ajouteBouton(@box,@boutonFlechePrecedent,1,55,45,(1200 *0.015),675 * 0.24,nil,@window,@boiteInterieure)
        ajouteBouton(@box,@boutonFlecheSuivant,1,55,45,(1200 *0.935),675 * 0.24,nil,@window,@boiteInterieure)

        for i in 0..classementChap1.length()-1
            @texteClassement.set_text("1 = "+classementChap1[i].to_s()+"\n")
            puts(classementChap1.to_s())
        end 

        @boutonMenu.signal_connect("clicked"){
            vers_menu(@window,@box)
        }

        @boutonFlechePrecedent.signal_connect("clicked"){
            indexChapitre = indexChapitre-1
            if indexChapitre==1
                @boutonFlechePrecedent.sensitive = false
            end
            if indexChapitre>1
                @boutonFlecheSuivant.sensitive = true
            end
            changerTitreChapitre(indexChapitre)
        }

        @boutonFlecheSuivant.signal_connect("clicked"){
            indexChapitre = indexChapitre+1
            if indexChapitre<10
                @boutonFlechePrecedent.sensitive = true
            end
            if indexChapitre==10
                @boutonFlecheSuivant.sensitive = false
            end
            changerTitreChapitre(indexChapitre)
        }

        @box.put(@titreChapitre,(1200 *0.3), 675 * 0.24)
        @box.put(@texteClassement,(1200 *0.1), 675 * 0.5)
        @box.add(@boiteInterieure)

        @window.add(@box)
        @window.show_all
    end

    def changerTitreChapitre(indexChapitre)
        case indexChapitre
        when 1 
            @titreChapitre.set_text("Chapitre "+indexChapitre.to_s()+" : Hawaï")
        when 2
            @titreChapitre.set_text("Chapitre "+indexChapitre.to_s()+" : Polynésie Française")
        when 3
            @titreChapitre.set_text("Chapitre "+indexChapitre.to_s()+" : Île de Pâques")
        when 4
            @titreChapitre.set_text("Chapitre "+indexChapitre.to_s()+" : Santorin")
        when 5
            @titreChapitre.set_text("Chapitre "+indexChapitre.to_s()+" : Mykonos")
        when 6
            @titreChapitre.set_text("Chapitre "+indexChapitre.to_s()+" : Corse")
        when 7
            @titreChapitre.set_text("Chapitre "+indexChapitre.to_s()+" : Maldives")
        when 8
            @titreChapitre.set_text("Chapitre "+indexChapitre.to_s()+" : Cuba")
        when 9
            @titreChapitre.set_text("Chapitre "+indexChapitre.to_s()+" : Sumatra")
        when 10
            @titreChapitre.set_text("Chapitre "+indexChapitre.to_s()+" : Les Galapagos")
        end
    end
end