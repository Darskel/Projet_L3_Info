    ##
    # Permet de passer à l'écran du menu
    def vers_menu(window,boite)
        window.remove(boite)
        @ecr  = Ecran_menu.creer(window)
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
    # * +css+       Le css a appliquer
    # * +witdh+     Largeur voulue pour le bouton
    # * +height+     Hauteur voulue pour le bouton
    def ajoutecssProvider(bouton, css, width, height)
        bouton.style_context.add_provider(css, Gtk::StyleProvider::PRIORITY_USER)
        bouton.set_size_request(width, height)
    end

    ##
    # Ajoute un bouton dans la boite en lui appliquant le css et le signal
    ##
    # * +boite+     La boite dans laquelle on range le bouton
    # * +bouton+    Le bouton à ajouter/modifier
    # * +typeCss+   Le css a appliquer sur le bouton
    # * +w+         La largeur que l'on veut appliquer au bouton
    # * +h+         La longueur que l'on veut appliquer au bouton
    # * +x+         L'emplacement en largeur auquel on veut placer le bouton
    # * +y+         L'emplacement en hauteur auquel on veut placer le bouton
    # * +callback+  La méthode à appliquer lors du signal connect
    # * +win+       La fenetre de l'application
    # * +box+       le Layout Manager de l'écran
    def ajouteBouton(boite, bouton, typeCss, w, h, x, y, callback, win, box)
        css = ajouteCss(typeCss)
        ajoutecssProvider(bouton, css, w, h)

        if (callback != nil) then
            bouton.signal_connect("clicked"){
                if (win && box)
                    callback.call(win, box)
                else
                    callback.call()
                end
            }
        end
        boite.put(bouton, x, y)
    end
    

    ##
    # Crée le css pour les textes en fonctions de l'etat passé en parametre 
    ##
    # * +etat+  le css demandé par l'user, 1 css pour les titres, 2 pour les descriptions texte
    def ajouteTexte(etat)
        css = Gtk::CssProvider.new

        if etat == 1
            css.load(data: <<-CSS)
            label {
                font-size: 50px;
                font-family: sans-serif;
            }
            CSS
        elsif etat == 2
            css.load(data: <<-CSS)
            label {
                font-size: 22px;
                font-family: sans-serif; 
            }
            CSS
        elsif etat == 3
            css.load(data: <<-CSS)
            label {
                font-size: 38px;
                font-family: sans-serif;
                text-shadow: 1px 0 0 black, 0 1px 0 black, -1px 0 0 black, 0 -1px 0 black;
            }
            CSS
        end
        return css
    end

    ##
    # Applique le css au texte et lui applique la taille voulue
    ##
    # * +texte+     Le texte auquel aplliquer le css
    # * +css+       Le css a appliquer
    def ajouteTexteProvider(texte, css)
        texte.style_context.add_provider(css, Gtk::StyleProvider::PRIORITY_USER) 
    end
    