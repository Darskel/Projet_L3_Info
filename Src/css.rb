##
# Classe représentant les différents css possibles
class Css

    ##
    # Création des différents css pour les boutons de la grille
    def initialize()
        @cssW = Gtk::CssProvider.new
        @cssB = Gtk::CssProvider.new
        @cssG = Gtk::CssProvider.new
        @cssWRedBorder = Gtk::CssProvider.new
        @cssBRedBorder = Gtk::CssProvider.new
        @cssGRedBorder = Gtk::CssProvider.new
        @falseReponse = Gtk::CssProvider.new
        @cssWWide = Gtk::CssProvider.new
        @cssWMed = Gtk::CssProvider.new
        @cssWWidemenu = Gtk::CssProvider.new
        @cssWMedmenu = Gtk::CssProvider.new


        # Css pour le fond blanc et la couleur de police noir
        @cssW.load(data: <<-CSS)
        button {
            background-image: image(white);
            color : black;
            border: 1px solid black;
            border-radius: 0px;
            box-shadow: 0 0 0 0px white inset;
        }
        CSS

        # Css pour le fond noir et la couleur de police blanc
        @cssB.load(data: <<-CSS)
        button {
            background-image: image(black);
            color : white;
            border: 1px solid white;
            border-radius: 0px;
            box-shadow: 0 0 0 0px black inset;
        }
        CSS

        # Css pour le fond gris et la couleur de police blanc
        @cssG.load(data: <<-CSS)
        button {
            background-image: image(grey);
            color : white;
            border: 1px solid white;
            border-radius: 0px;
            box-shadow: 0 0 0 0px grey inset;
        }
        CSS

        # Css pour ajouter une bordure rouge, symbole d'une case fausse
        @falseReponse.load(data: <<-CSS)
        button {
            border: 1px groove red;
            box-shadow: 0 0 0 3px red inset;
        }
        CSS

        #Css pour ajouter une bordure rouge sur une case blanche, symbole que l'aide Redsquare est activé
        @cssWRedBorder.load(data: <<-CSS)
        button {
            background-image: image(white);
            color : black;
            border: 1px solid red;
            border-radius: 0px;
            box-shadow: 0 0 0 1px red inset;
        }
        CSS

        #Css pour ajouter une bordure rouge sur une case noire, symbole que l'aide Redsquare est activé
        @cssBRedBorder.load(data: <<-CSS)
        button {
            background-image: image(black);
            color : white;
            border: 1px solid red;
            border-radius: 0px;
            box-shadow: 0 0 0 1px red inset;
        }
        CSS
        #Css pour ajouter une bordure rouge sur une case grise, symbole que l'aide Redsquare est activé
        @cssGRedBorder.load(data: <<-CSS)
        button {
            background-image: image(grey);
            color : white;
            border: 1px solid red;
            border-radius: 0px;
            box-shadow: 0 0 0 1px red inset;
        }
        CSS

        @cssWMed.load(data: <<-CSS)
        button{
            background-image: image(white);
            color : black;
            border: 1px solid black;
            border-radius: 0px;
            box-shadow: 0 0 0 0px white inset;
            padding-top: 0px; 
            padding-bottom: 0px;
            padding-left: 13px;
            padding-right: 13px;
        }
        CSS

        @cssWWide.load(data: <<-CSS)
        button{
            background-image: image(white);
            color : black;
            border: 1px solid black;
            border-radius: 0px;
            box-shadow: 0 0 0 0px white inset;
            padding-top: 0px; 
            padding-bottom: 0px;
            padding-left: 10px;
            padding-right: 10px;
        }
        CSS

        @cssWMedmenu.load(data: <<-CSS)
        button{
            background-image: image(white);
            color : black;
            border: 1px solid black;
            border-radius: 0px;
            box-shadow: 0 0 0 0px white inset;
            padding-top: 0px; 
            padding-bottom: 0px;
            padding-left: 8px;
            padding-right: 8px;
        }
        CSS

        @cssWWidemenu.load(data: <<-CSS)
        button{
            background-image: image(white);
            color : black;
            border: 1px solid black;
            border-radius: 0px;
            box-shadow: 0 0 0 0px white inset;
            padding-top: 0px; 
            padding-bottom: 0px;
            padding-left: 5px;
            padding-right: 5px;
        }
        CSS
    end

    attr_reader :cssG, :cssB, :cssW, :cssBRedBorder, :cssWRedBorder, :cssGRedBorder, :falseReponse, :cssWMed, :cssWWide, :cssWMedmenu, :cssWWidemenu
end