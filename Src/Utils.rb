    ##
    # Permet de passer à l'écran du menu
    ##
    # * +window+      Fenetre graphique de l'application
    # * +boite+       Layout manager principal de l'écran en cours
    def vers_menu(window,boite)
        window.remove(boite)
        Ecran_menu.creer(window)
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
        elsif etat == 2
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
        elsif etat == 3
            css.load(data: <<-CSS)
            button {
                opacity: 1;
                background: rgba(117, 190, 218, 0.0); 
                border: unset;
            }
            button:hover {
                opacity: 0.8;
                border: unset;
            }
            CSS
        end
        return css
    end


    ## 
    # Applique le css au bouton et lui applique la taille voulue
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
    # * +p1+        Paramètre de l'event
    # * +p2+        Paramètre de l'event
    def ajouteBouton(boite, bouton, typeCss, w, h, x, y, callback, p1, p2)
        css = ajouteCss(typeCss)
        ajoutecssProvider(bouton, css, w, h)

        if (callback != nil) then
            bouton.signal_connect("clicked"){
                if (p1 && p2)
                    callback.call(p1, p2)
                elsif (p1)
                    callback.call(p1)
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
                text-shadow: 1px 0 0 black, 0 1px 0 black, -1px 0 0 black, 0 -1px 0 black;
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
                font-size: 34px;
                font-family: sans-serif;
                text-shadow: 1px 0 0 black, 0 1px 0 black, -1px 0 0 black, 0 -1px 0 black;
            }
            CSS
        elsif etat == 4
            css.load(data: <<-CSS)
            label {
                font-size: 34px;
                font-family: sans-serif; 
                color: grey;
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
    