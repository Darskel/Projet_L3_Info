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

        boite.add(Gtk::Image.new(:file => "../maquettes/texture_liege.jpg"))

        @layoutManager.add(boite)
        @win.add(@layoutManager)

        saisie = Gtk::Entry.new()
        valider = Gtk::Button.new(:label => "Valider")
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
                newUser(saisie.text)
                vers_menu()
            end
        }

        widthEcran = 600
        heightEcran = 600

        css = Gtk::CssProvider.new
        css.load(data: <<-CSS)
            button {
                opacity: 0.5;
                border: unset;
                color: black;
            }
            button:hover {
                opacity: 0.8;
                border: 1px solid black;
            }
        CSS


        ajoutecssProvider(valider, css, 120, 50)

        
        boite.put(valider, (widthEcran *0.4), heightEcran * 0.55)
        boite.put(choixExistant, (widthEcran *0.6), heightEcran * 0.4)
        boite.put(saisie, (widthEcran *0.2), heightEcran * 0.4)


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
    # Ajout d'un nouvel utilisateur
    ##
    # * +nom+   nom de l'utilisateur
    def newUser(nom)
        File.open($userPath + "users.txt", "w")
        File.chmod(0777,$userPath + "users.txt")
        File.write($userPath + "users.txt", nom+"\n", mode: "a")

        $userPath += nom+"/"
        Dir.mkdir($userPath)

        File.open($userPath+"config.txt", "w")
        File.chmod(0777,$userPath + "config.txt")
        File.write($userPath+"config.txt", "sound", mode: "a")
    end
end
