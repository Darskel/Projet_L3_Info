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
        @indexChapitre = 1
        @titreChapitre = Gtk::Label.new()
        @titreChapitre.set_text("Chapitre "+@indexChapitre.to_s()+" : Hawaï")
        @boxClassement = Gtk::Box.new(:horizontal)
        
        #Création des labels pour le nom de joueurs dans le classement
        @texte1er = Gtk::Label.new()
        @texte2e = Gtk::Label.new()
        @texte3e = Gtk::Label.new()
        @texte4e = Gtk::Label.new()
        @texte5e = Gtk::Label.new()
        
        #Création des labels pour le numéro de la place des joueurs dans le classement ( limitées à 5 )
        @place1 = Gtk::Label.new()
        @place2 = Gtk::Label.new()
        @place3 = Gtk::Label.new()
        @place4 = Gtk::Label.new()
        @place5 = Gtk::Label.new()
        
        #Création des labels pour le temps des joueurs dans le classement
        @temps1er = Gtk::Label.new()
        @temps2e = Gtk::Label.new()
        @temps3e = Gtk::Label.new()
        @temps4e = Gtk::Label.new()
        @temps5e = Gtk::Label.new()

        #Création des boutons permettant de retourner au menu et de changer les chapitres        
        @boutonFlecheSuivant = Gtk::Button.new()
        @boutonFlechePrecedent = Gtk::Button.new()  
        @boutonMenu = Gtk::Button.new()

        #Création des différents tableaux pour le stockage du classement 
        @classementChapActuel = []
        @userMinutes = []
        @userSecondes = []

        affichageClassement()
        comparerTemps()
        placementClassement()

        @box.add(Gtk::Image.new(:file => "../maquettes/classement.png"))

        cssChapitre = ajouteTexte(3)
        ajouteTexteProvider(@titreChapitre,cssChapitre)
        
        
        ajouteBouton(@box,@boutonMenu,1,55,45,(1200 *0.015),675 * 0.025,nil,@window,@boiteInterieure)
        ajouteBouton(@box,@boutonFlechePrecedent,1,55,45,(1200 *0.015),675 * 0.24,nil,@window,@boiteInterieure)
        ajouteBouton(@box,@boutonFlecheSuivant,1,55,45,(1200 *0.935),675 * 0.24,nil,@window,@boiteInterieure)

        #Signal du bouton menu pour retourner vers le menu
        @boutonMenu.signal_connect("clicked"){
            vers_menu(@window,@box)
        }

        #Signal du bouton flèche précédent pour changer le numéro du chapitre
        @boutonFlechePrecedent.signal_connect("clicked"){
            @classementChapActuel = []
            @userMinutes = []
            @userSecondes = []
            @indexChapitre = @indexChapitre-1
            clearClassement()
            affichageClassement()
            comparerTemps()
            placementClassement()
            if @indexChapitre==1
                @boutonFlechePrecedent.sensitive = false
            end
            if @indexChapitre>1
                @boutonFlecheSuivant.sensitive = true
            end
            changerTitreChapitre(@indexChapitre)
        }

        #Signal du bouton flèche suivant pour changer le numéro du chapitre
        @boutonFlecheSuivant.signal_connect("clicked"){
            @classementChapActuel = []
            @userMinutes = []
            @userSecondes = []
            @indexChapitre = @indexChapitre+1
            clearClassement()
            affichageClassement()
            comparerTemps()
            placementClassement()
            if @indexChapitre<10
                @boutonFlechePrecedent.sensitive = true
            end
            if @indexChapitre==10
                @boutonFlecheSuivant.sensitive = false
            end
            changerTitreChapitre(@indexChapitre)
        }

        #Placement de tous les éléments sur la fenêtre
        @box.put(@titreChapitre,(1200 *0.3), 675 * 0.24)
        
        @box.put(@place1,(1200 *0.05), 675 * 0.5)
        @box.put(@place2,(1200 *0.05), 675 * 0.6)
        @box.put(@place3,(1200 *0.05), 675 * 0.7)
        @box.put(@place4,(1200 *0.05), 675 * 0.8)
        @box.put(@place5,(1200 *0.05), 675 * 0.9)

        @box.put(@texte1er,(1200 *0.12), 675 * 0.5)
        @box.put(@texte2e,(1200 *0.12), 675 * 0.6)
        @box.put(@texte3e,(1200 *0.12), 675 * 0.7)
        @box.put(@texte4e,(1200 *0.12), 675 * 0.8)
        @box.put(@texte5e,(1200 *0.12), 675 * 0.9)

        @box.put(@temps1er,(1200 *0.6), 675 * 0.5)
        @box.put(@temps2e,(1200 *0.6), 675 * 0.6)
        @box.put(@temps3e,(1200 *0.6), 675 * 0.7)
        @box.put(@temps4e,(1200 *0.6), 675 * 0.8)
        @box.put(@temps5e,(1200 *0.6), 675 * 0.9)

        @box.add(@boiteInterieure)

        @window.add(@box)
        @window.show_all
    end

    #Fonction permettant de changer le nom du chapitre afficher dans le label @titreChapitre en fonction du numéro de chapitre
    # +indexChapitre+ numéro du chapitre
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

    #Fonction permettant la récupération des données pour réaliser le classement
    def affichageClassement()
        fileUsers = File.open("../Users/users.txt","r") 
        file_data = fileUsers.readlines.map(&:chomp)
        #Parcours du fichier contenant tous les utilisateurs
        for elem in file_data do
            fileUtilisateur = File.open("../Users/"+elem.to_s()+"/succes.txt")
            lignesFichierUtilisateur = fileUtilisateur.readlines.map(&:chomp)
            tabLigne = lignesFichierUtilisateur[@indexChapitre-1].split(" ")
            if( (tabLigne[1] == "0"  && tabLigne[2] != "0") || (  tabLigne[1] != "0" && tabLigne[2] == "0") || (  tabLigne[1] != "0" && tabLigne[2] != "0"))
                @classementChapActuel<<elem.to_s
                @userMinutes<<tabLigne[1]
                @userSecondes<<tabLigne[2]
            end
        end
    end

    #Fonction permettant le placement des données dans les différents labels
    def placementClassement()
        cssTexteClassement = ajouteTexte(3)
        #Affichage du classement
        for i in 0..@classementChapActuel.length()-1
            case i
            when 0
                ajouteTexteProvider(@place1,cssTexteClassement)
                ajouteTexteProvider(@texte1er,cssTexteClassement)
                ajouteTexteProvider(@temps1er,cssTexteClassement)
                @place1.set_text((i+1).to_s())
                @texte1er.set_text(@classementChapActuel[i].to_s())
                @temps1er.set_text(@userMinutes[i].to_s() + " minutes "+@userSecondes[i].to_s()+ " secondes ")
            when 1 
                ajouteTexteProvider(@place2,cssTexteClassement)
                ajouteTexteProvider(@texte2e,cssTexteClassement)
                ajouteTexteProvider(@temps2e,cssTexteClassement)
                @place2.set_text((i+1).to_s())
                @texte2e.set_text(@classementChapActuel[i].to_s())
                @temps2e.set_text(@userMinutes[i].to_s() + " minutes "+@userSecondes[i].to_s()+ " secondes ")
            when 2
                ajouteTexteProvider(@place3,cssTexteClassement)
                ajouteTexteProvider(@texte3e,cssTexteClassement)
                ajouteTexteProvider(@temps3e,cssTexteClassement)
                @place3.set_text((i+1).to_s())
                @texte3e.set_text(@classementChapActuel[i].to_s())
                @temps3e.set_text(@userMinutes[i].to_s() + " minutes "+@userSecondes[i].to_s()+ " secondes ")
            when 3
                ajouteTexteProvider(@place4,cssTexteClassement)
                ajouteTexteProvider(@texte4e,cssTexteClassement)
                ajouteTexteProvider(@temps4e,cssTexteClassement)
                @place4.set_text((i+1).to_s())
                @texte4e.set_text(@classementChapActuel[i].to_s())
                @temps4e.set_text(@userMinutes[i].to_s() + " minutes "+@userSecondes[i].to_s()+ " secondes ")
            when 4
                ajouteTexteProvider(@place5,cssTexteClassement)
                ajouteTexteProvider(@texte5e,cssTexteClassement)
                ajouteTexteProvider(@temps5e,cssTexteClassement)
                @place5.set_text((i+1).to_s())
                @texte5e.set_text(@classementChapActuel[i].to_s())
                @temps5e.set_text(@userMinutes[i].to_s() + " minutes "+@userSecondes[i].to_s()+ " secondes ")
            end
        end
        @window.show_all()
    end

    #Fonction permettant de vider les labels du classement
    def clearClassement()
        @place1.set_text("")
        @texte1er.set_text("")
        @temps1er.set_text("")
        @place2.set_text("")
        @texte2e.set_text("")
        @temps2e.set_text("")
        @place3.set_text("")
        @texte3e.set_text("")
        @temps3e.set_text("")
        @place4.set_text("")
        @texte4e.set_text("")
        @temps4e.set_text("")
        @place5.set_text("")
        @texte5e.set_text("")
        @temps5e.set_text("")
        @window.show_all()
    end

    #Fonction permettant de comparer le temps des utilisateurs afin de réaliser un classement dynamique
    def comparerTemps()
        changementEffectue = true
        while(changementEffectue == true)
            changementEffectue = false
            for i in 0..@classementChapActuel.length()-2
                if(@userMinutes[i] > @userMinutes[i+1])
                    changementEffectue = true

                    userMinTmp = @userMinutes[i]
                    @userMinutes[i] = @userMinutes[i+1]
                    @userMinutes[i+1] = userMinTmp

                    userSecTmp = @userSecondes[i]
                    @userSecondes[i] = @userSecondes[i+1]
                    @userSecondes[i+1] = userSecTmp

                    classementChapTmp = @classementChapActuel[i]
                    @classementChapActuel[i] = @classementChapActuel[i+1]
                    @classementChapActuel[i+1] = classementChapTmp
                    
                elsif(@userMinutes[i] == @userMinutes[i+1])
                    if(@userSecondes[i] > @userSecondes[i+1])
                        changementEffectue = true

                        userSecTmp = @userSecondes[i]
                        @userSecondes[i] = @userSecondes[i+1]
                        @userSecondes[i+1] = userSecTmp

                        classementChapTmp = @classementChapActuel[i]
                        @classementChapActuel[i] = @classementChapActuel[i+1]
                        @classementChapActuel[i+1] = classementChapTmp
                    end
                end
            end   
        end
    end 
end