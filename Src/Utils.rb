class Utils
        
    ##
    # Permet de passer à l'écran du menu
    def vers_menu(window)
        @win = window
        @win.remove(@boite)
        @ecr  = Ecran_menu.creer(@win)
    end

end