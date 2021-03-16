
require 'gtk3'

Gtk.init

##
# Création de la fenetre
win = Gtk::Window.new()
win.set_title("TEST")
win.set_default_size(600, 400)

win.signal_connect('destroy'){
    Gtk.main_quit
}

inputter_event = Gtk::EventBox.new
inputter_event.events = Gdk::EventMask::KEY_PRESS_MASK

#tweetbutton = Gtk::Button.new(:label => "oui")


table = Gtk::Frame.new()  #Table.new(4, 9, true)
#table.attach(tweetbutton, 3, 6, 3, 4)


inputter_event.add(table)
win.add(inputter_event)

inputter_event.realize

inputter_event.signal_connect('key-press-event') do |wdt, evt|
    key = Gdk::Keyval.to_name(evt.keyval)
    p ("KeyPress: #{ key }was pressed")      # these lines
    p evt.state                              # are for 
    p evt.keyval                             # debugging
end

win.show_all
Gtk.main