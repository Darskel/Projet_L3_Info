##
# Ecran qui permet à l'utilisateur de se connecter à ses sauvegardes
##
# * +win+               La fenetre de l'application
# * +layoutManager+     Le layout principal pour le placement dans la fenetre
class Connexion

    ##
    # Constructeur
    ##
    # * +win+   Fenetre de l'application
    def Connexion.creer(win)
        new(win)
    end

    private_class_method :new

    ##
    # Création du contenu de l'écran de connexion
    ##
    # * +win+   La fenetre de l'application
    def initialize(win)

        @win = win
        @win.set_title("Connexion")
        @win.set_default_size(600, 600)

        boite = Gtk::Fixed.new()
        @layoutManager = Gtk::Box.new(:vertical)

        boite.add(Gtk::Image.new(:file => "../maquettes/connexion.png"))

        @layoutManager.add(boite)
        @win.add(@layoutManager)

        saisie = Gtk::Entry.new()
        valider = Gtk::Button.new(:label => " ")
        choixExistant = Gtk::ComboBoxText.new

        choixExistant.append_text "Sélectionner votre session"
        choixExistant.active= 0

        chargerExistants(choixExistant)

        valider.signal_connect("clicked"){
            if saisie.text.length == 0
                if choixExistant.active != 0
                    $userPath += choixExistant.active_text+"/"
                    vers_menu()
                end
            else
                if checkUser(saisie.text)
                    newUser(saisie.text)
                else
                    $userPath += saisie.text+"/"
                end
                vers_menu()
            end
        }

        widthEcran = 600
        heightEcran = 600

        css = Gtk::CssProvider.new
        css.load(data: <<-CSS)
            button {
                opacity: 0;
                border: unset;
                color: black;
            }
            button:hover {
                opacity: 0.1;
                border: 1px solid black;
            }
        CSS

        ajoutecssProvider(valider, css, 60, 55)

        boite.put(valider, (widthEcran *0.88), heightEcran * 0.89)
        boite.put(choixExistant, (widthEcran *0.45), heightEcran * 0.8)
        boite.put(saisie, (widthEcran *0.47), heightEcran * 0.4)


        @win.show_all
        Gtk.main
    end

    ##
    # Charge les utilisateurs dans la combobox
    ##
    # * +combobox+  La combobox à remplir
    def chargerExistants(combobox)
        file = File.open($userPath + "users.txt")
        file_data = file.readlines.map(&:chomp)

        for i in file_data do
            combobox.append_text i
        end
        file.close
    end

    ##
    # Redirige vers le menu principal
    def vers_menu
        @win.set_title("FILL A PIX")
        @win.set_default_size(1200, 675)
        
        @win.remove(@layoutManager)

        Ecran_menu.creer(@win)
        return self
    end

    ##
    # Vérifie si l'utilisateur existe déjà. Retourne vrai si l'utilisateur n'existe pas encore
    ##
    # * +nom+   Saisie de l'utilisateur 
    def checkUser(nom)

        file = File.open($userPath + "users.txt")
        file_data = file.readlines.map(&:chomp)

        for elem in file_data do
            if nom == elem
                return false
            end
        end
        return true
    end

    ##
    # Ajout d'un nouvel utilisateur
    ##
    # * +nom+   nom de l'utilisateur
    def newUser(nom)
        File.open($userPath + "users.txt", "a")
        File.chmod(0777,$userPath + "users.txt")
        File.write($userPath + "users.txt", nom+"\n", mode: "a")

        ##Ajout des dossiers 'Libre' et 'Aventure' 
        ##qui contiendront les sauvegardes de ces modes respectifs 
        $userPath += nom+"/"
        Dir.mkdir($userPath)
        Dir.mkdir($userPath+"Libre/")
        Dir.mkdir($userPath+"Aventure/")

        ##Ajout des premiers fichiers nécessaires pour un nouvel utilisateur
        File.open($userPath+"config.txt", "w")
        File.chmod(0777,$userPath + "config.txt")
        File.write($userPath+"config.txt", "Sons : true")

        File.open($userPath+"succes.txt", "w")
        File.chmod(0777,$userPath + "succes.txt")
        i = 0
        while i <= 11 do
            File.write($userPath+"succes.txt", "false 0 0\n", mode: "a")
            i+=1
        end
    end
end
