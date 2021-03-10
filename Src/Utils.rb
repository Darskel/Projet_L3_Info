    ##
    # Permet de passer à l'écran du menu
    def vers_menu(window,boite)
        @win = window
        @win.remove(boite)
        @ecr  = Ecran_menu.creer(@win)
    end
