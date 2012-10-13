require 'gtk2'

class MainWindow < Gtk::Window
  def cb_play_pause
    puts "Button Pressed"
  end

  def initialize
    super

    @mainVBox = Gtk::VBox.new(false, 0)
    @controlBox = Gtk::HBox.new(false, 0)
    @volSliderBox = Gtk::HBox.new(false, 0)

    @controlAlignment = Gtk::Alignment.new(0.5, 0.5, 0, 0)
    @controlAlignment.add(@controlBox)
 
    @playIcon = Gtk::Image.new(Gtk::Stock::MEDIA_PLAY, \
                              Gtk::IconSize::SMALL_TOOLBAR)
    @pauseIcon = Gtk::Image.new(Gtk::Stock::MEDIA_PAUSE, \
                              Gtk::IconSize::SMALL_TOOLBAR)
    @nextIcon = Gtk::Image.new(Gtk::Stock::MEDIA_NEXT, \
                              Gtk::IconSize::SMALL_TOOLBAR)
    @previousIcon = Gtk::Image.new(Gtk::Stock::MEDIA_PREVIOUS, \
                              Gtk::IconSize::SMALL_TOOLBAR)

    @playEventBox = Gtk::EventBox.new()
    @playEventBox.add(@playIcon)
    @playEventBox.events = Gdk::Event::BUTTON_PRESS_MASK

    @pauseEventBox = Gtk::EventBox.new()
    @pauseEventBox.add(@pauseIcon)
    @pauseEventBox.events = Gdk::Event::BUTTON_PRESS_MASK

    @nextEventBox = Gtk::EventBox.new()
    @nextEventBox.add(@nextIcon)
    @nextEventBox.events = Gdk::Event::BUTTON_PRESS_MASK

    @previousEventBox = Gtk::EventBox.new()
    @previousEventBox.add(@previousIcon)
    @previousEventBox.events = Gdk::Event::BUTTON_PRESS_MASK

    @controlBox.pack_start(@playEventBox, false, false, 0)
    @controlBox.pack_start(@pauseEventBox, false, false, 0)
    @controlBox.pack_start(@nextEventBox, false, false, 0)
    @controlBox.pack_start(@previousEventBox, false, false, 0)

    @mainVBox.pack_start(@controlAlignment, false, false, 0)
    @mainVBox.pack_start(Gtk::HSeparator.new, false, false, 0)

    add(@mainVBox)

    @playEventBox.realize
    @playEventBox.window.cursor = Gdk::Cursor.new(Gdk::Cursor::HAND1)
    @playEventBox.signal_connect('button_press_event') { cb_play_pause }

    @pauseEventBox.realize
    @pauseEventBox.window.cursor = Gdk::Cursor.new(Gdk::Cursor::HAND1)
    @pauseEventBox.signal_connect('button_press_event') { cb_play_pause }

    @nextEventBox.realize
    @nextEventBox.window.cursor = Gdk::Cursor.new(Gdk::Cursor::HAND1)
    @nextEventBox.signal_connect('button_press_event') { cb_play_pause }

    @previousEventBox.realize
    @previousEventBox.window.cursor = Gdk::Cursor.new(Gdk::Cursor::HAND1)
    @previousEventBox.signal_connect('button_press_event') { cb_play_pause }

  end
end

win = MainWindow.new
win.show_all
win.border_width = 10
Gtk.main
