    ##
    # Permet de passer à l'écran du menu
    def vers_menu(window,boite)
        @win = window
        @win.remove(boite)
        @ecr  = Ecran_menu.creer(@win)
    end


    ##
    # Crée et retourne le css correspondant à l'état passé
    ##
    # * +etat+  le css demandé par l'user, 1 css sans hover, 2 avec hover
    def ajouteCss(etat)

        css = Gtk::CssProvider.new

        if etat == 1

            css.load(data: <<-CSS)
            button {
                opacity: 0;
                border: unset;
            }
            CSS
        else
            css.load(data: <<-CSS)
            button {
                opacity: 0;
                border: unset;
            }
            button:hover {
                opacity: 0.1;
                border: 1px solid black;
            }
            CSS
        end
        return css
    end


    ## Applique le css au bouton et lui applique la taille voulue
    ##
    # * +bouton+    Le bouton auquel appliqué les modifications
    # * +css+       Le css a appliqué
    # * +witdh+     Largeur voulue pour le bouton
    # * +height+     Hauteur voulue pour le bouton
    def ajoutecssProvider(bouton, css, width, height)
        bouton.style_context.add_provider(css, Gtk::StyleProvider::PRIORITY_USER)
        bouton.set_size_request(width, height)
    end