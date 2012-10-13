require 'gtk2'

class MainWindow < Gtk::Window
  def cb_play_pause
    puts "Play Button Pressed"
  end

  def initialize
    super

    @mainVBox = Gtk::VBox.new(false, 0)
    @controlBox = Gtk::HBox.new(false, 0)
    @volSliderBox = Gtk::HBox.new(false, 0)

    @controlAlignment = Gtk::Alignment.new(0.5, 0.5, 0, 0)
    @controlAlignment.add(@controlBox)
 
    playIcon = Gtk::Image.new(Gtk::Stock::MEDIA_PLAY, \
                              Gtk::IconSize::SMALL_TOOLBAR)
    @playEventBox = Gtk::EventBox.new()
    @playEventBox.add(playIcon)
    @playEventBox.events = Gdk::Event::BUTTON_PRESS_MASK

    @controlBox.pack_start(@playEventBox, false, false, 0)

    @mainVBox.pack_start(@controlAlignment, false, false, 0)
    @mainVBox.pack_start(Gtk::HSeparator.new, false, false, 0)

    add(@mainVBox)

    @playEventBox.realize
    @playEventBox.window.cursor = Gdk::Cursor.new(Gdk::Cursor::HAND1)

    @playEventBox.signal_connect('button_press_event') { cb_play_pause }

  end
end

win = MainWindow.new
win.show_all
win.border_width = 10
Gtk.main
