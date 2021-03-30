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
        
        texte1er = Gtk::Label.new()
        texte2e = Gtk::Label.new()
        texte3e = Gtk::Label.new()
        texte4e = Gtk::Label.new()
        texte5e = Gtk::Label.new()
        
        place1 = Gtk::Label.new()
        place2 = Gtk::Label.new()
        place3 = Gtk::Label.new()
        place4 = Gtk::Label.new()
        place5 = Gtk::Label.new()
        
        temps1er = Gtk::Label.new()
        temps2e = Gtk::Label.new()
        temps3e = Gtk::Label.new()
        temps4e = Gtk::Label.new()
        temps5e = Gtk::Label.new()
        
        @boutonFlecheSuivant = Gtk::Button.new()
        @boutonFlechePrecedent = Gtk::Button.new()  
        @boutonMenu = Gtk::Button.new()

        
        fileUsers = File.open("../Users/users.txt","r") 
        file_data = fileUsers.readlines.map(&:chomp)
        i = 1
        
        #Parcours du fichier contenant tous les utilisateurs
        for elem in file_data do
            fileUtilisateur = File.open("../Users/"+elem.to_s()+"/succes.txt")
            lignesFichierUtilisateur = fileUtilisateur.readlines.map(&:chomp)
            #puts("Fichier de "+elem.to_s()+" : \n")
            
            #Parcours du fichier succes de l'utilisateur elem 
            for chapitre in lignesFichierUtilisateur do
                #puts("Chapitre n°"+i.to_s()+" : ")
                #if(i==12)
                #    i=0
                #end
                #i = i+1    
                tabLigne = chapitre.split(" ")
                tabLigne.each{|x| print x,"\n"}
            end
        end

        classementChap1 = ["Arthur","Yannis","Aurélien","Guillaume","David"]
        userTime1 = ["1 min 05 secondes","2 min 30 secondes","2 min 35 secondes","2 min 45 secondes","3 min 00 secondes"]
        classementChap2 = ["David","Arthur","Alexis"]
        classementChap3 = ["Alexis","Arthur","Tom"]

        @box.add(Gtk::Image.new(:file => "../maquettes/classement.png"))

        cssChapitre = ajouteTexte(3)
        cssTexteClassement = ajouteTexte(3)
        ajouteTexteProvider(@titreChapitre,cssChapitre)
        
        
        ajouteBouton(@box,@boutonMenu,1,55,45,(1200 *0.015),675 * 0.025,nil,@window,@boiteInterieure)
        ajouteBouton(@box,@boutonFlechePrecedent,1,55,45,(1200 *0.015),675 * 0.24,nil,@window,@boiteInterieure)
        ajouteBouton(@box,@boutonFlecheSuivant,1,55,45,(1200 *0.935),675 * 0.24,nil,@window,@boiteInterieure)

        for i in 0..classementChap1.length()-1
            case i
            when 0
                ajouteTexteProvider(place1,cssTexteClassement)
                ajouteTexteProvider(texte1er,cssTexteClassement)
                ajouteTexteProvider(temps1er,cssTexteClassement)
                place1.set_text((i+1).to_s())
                texte1er.set_text(classementChap1[i].to_s())
                temps1er.set_text(userTime1[i].to_s())
            when 1 
                ajouteTexteProvider(place2,cssTexteClassement)
                ajouteTexteProvider(texte2e,cssTexteClassement)
                ajouteTexteProvider(temps2e,cssTexteClassement)
                place2.set_text((i+1).to_s())
                texte2e.set_text(classementChap1[i].to_s())
                temps2e.set_text(userTime1[i].to_s())
            when 2
                ajouteTexteProvider(place3,cssTexteClassement)
                ajouteTexteProvider(texte3e,cssTexteClassement)
                ajouteTexteProvider(temps3e,cssTexteClassement)
                place3.set_text((i+1).to_s())
                texte3e.set_text(classementChap1[i].to_s())
                temps3e.set_text(userTime1[i].to_s())
            when 3
                ajouteTexteProvider(place4,cssTexteClassement)
                ajouteTexteProvider(texte4e,cssTexteClassement)
                ajouteTexteProvider(temps4e,cssTexteClassement)
                place4.set_text((i+1).to_s())
                texte4e.set_text(classementChap1[i].to_s())
                temps4e.set_text(userTime1[i].to_s())
            when 4
                ajouteTexteProvider(place5,cssTexteClassement)
                ajouteTexteProvider(texte5e,cssTexteClassement)
                ajouteTexteProvider(temps5e,cssTexteClassement)
                place5.set_text((i+1).to_s())
                texte5e.set_text(classementChap1[i].to_s())
                temps5e.set_text(userTime1[i].to_s())
            end
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
        
        @box.put(place1,(1200 *0.05), 675 * 0.5)
        @box.put(place2,(1200 *0.05), 675 * 0.6)
        @box.put(place3,(1200 *0.05), 675 * 0.7)
        @box.put(place4,(1200 *0.05), 675 * 0.8)
        @box.put(place5,(1200 *0.05), 675 * 0.9)

        @box.put(texte1er,(1200 *0.12), 675 * 0.5)
        @box.put(texte2e,(1200 *0.12), 675 * 0.6)
        @box.put(texte3e,(1200 *0.12), 675 * 0.7)
        @box.put(texte4e,(1200 *0.12), 675 * 0.8)
        @box.put(texte5e,(1200 *0.12), 675 * 0.9)

        @box.put(temps1er,(1200 *0.6), 675 * 0.5)
        @box.put(temps2e,(1200 *0.6), 675 * 0.6)
        @box.put(temps3e,(1200 *0.6), 675 * 0.7)
        @box.put(temps4e,(1200 *0.6), 675 * 0.8)
        @box.put(temps5e,(1200 *0.6), 675 * 0.9)

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

    def comparerTemps(minute, seconde)
        if(this.minute < minute)
        
        end
    end
end