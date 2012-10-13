require 'gtk2'
require './callbacks'

class MainTrayIcon < Gtk::StatusIcon
  attr_reader :menu
  def initialize
    super
    self.stock = Gtk::Stock::MEDIA_PLAY
    self.tooltip = "YAMPDC"
  
    openMainWindow = Gtk::MenuItem.new("Open YAMPDC")
    quit = Gtk::MenuItem.new("Quit")
  
    quit.signal_connect("activate") { Gtk::main_quit }
    openMainWindow.signal_connect("activate") do
      window = MainWindow.new
      window.show_all
    end
  
    menu = Gtk::Menu.new
    menu.append(openMainWindow)
    menu.append(quit)
    menu.show_all

    signal_connect("popup-menu") do |tray, button, time|
      menu.popup(nil, nil, button, time)
    end
  
    signal_connect("activate") do
      window = MainWindow.new
      window.show_all
    end
  end
end

class MainWindow < Gtk::Window
  include Callback
  def initialize
    super

    @border_width = 10

    mainVBox = Gtk::VBox.new(false, 0)
    controlBox = Gtk::HBox.new(false, 0)
    volSliderBox = Gtk::HBox.new(false, 0)

    controlAlignment = Gtk::Alignment.new(0.5, 0.5, 0, 0)
    controlAlignment.add(controlBox)
 
    playIcon = Gtk::Image.new(Gtk::Stock::MEDIA_PLAY, \
                              Gtk::IconSize::SMALL_TOOLBAR)
    pauseIcon = Gtk::Image.new(Gtk::Stock::MEDIA_PAUSE, \
                              Gtk::IconSize::SMALL_TOOLBAR)
    nextIcon = Gtk::Image.new(Gtk::Stock::MEDIA_NEXT, \
                              Gtk::IconSize::SMALL_TOOLBAR)
    prevIcon = Gtk::Image.new(Gtk::Stock::MEDIA_PREVIOUS, \
                              Gtk::IconSize::SMALL_TOOLBAR)
    stopIcon = Gtk::Image.new(Gtk::Stock::MEDIA_STOP, \
                               Gtk::IconSize::SMALL_TOOLBAR)

    playButton = Gtk::Button.new
    playButton.image = playIcon

    stopButton = Gtk::Button.new
    stopButton.image = stopIcon

    nextButton = Gtk::Button.new
    nextButton.image = nextIcon

    prevButton = Gtk::Button.new
    prevButton.image = prevIcon

#    #### Switched from eventboxes to buttons!!!###
#    playEventBox = Gtk::EventBox.new()
#    playEventBox.add(playIcon)
#    playEventBox.events = Gdk::Event::BUTTON_PRESS_MASK
#
#    pauseEventBox = Gtk::EventBox.new()
#    pauseEventBox.add(pauseIcon)
#    pauseEventBox.events = Gdk::Event::BUTTON_PRESS_MASK
#
#    nextEventBox = Gtk::EventBox.new()
#    nextEventBox.add(nextIcon)
#    nextEventBox.events = Gdk::Event::BUTTON_PRESS_MASK
#
#    prevEventBox = Gtk::EventBox.new()
#    prevEventBox.add(prevIcon)
#    prevEventBox.events = Gdk::Event::BUTTON_PRESS_MASK

    playButton.relief = Gtk::RELIEF_NONE
    stopButton.relief = Gtk::RELIEF_NONE
    nextButton.relief = Gtk::RELIEF_NONE
    prevButton.relief = Gtk::RELIEF_NONE

    playButton.signal_connect("clicked") {cb_play_pause}
    stopButton.signal_connect("clicked") {cb_stop}
    nextButton.signal_connect("clicked") {cb_next}
    prevButton.signal_connect("clicked") {cb_prev}

    controlBox.pack_start(prevButton, false, false, 0)
    controlBox.pack_start(playButton, false, false, 0)
    controlBox.pack_start(stopButton, false, false, 0)
    controlBox.pack_start(nextButton, false, false, 0)

    mainVBox.pack_start(controlAlignment, false, false, 0)
    mainVBox.pack_start(Gtk::HSeparator.new, false, false, 0)

    add(mainVBox)

#    playEventBox.realize
#    playEventBox.window.cursor = Gdk::Cursor.new(Gdk::Cursor::HAND1)
#    playEventBox.signal_connect('button_press_event') { cb_play_pause }
#
#    pauseEventBox.realize
#    pauseEventBox.window.cursor = Gdk::Cursor.new(Gdk::Cursor::HAND1)
#    pauseEventBox.signal_connect('button_press_event') { cb_play_pause }
#
#    nextEventBox.realize
#    nextEventBox.window.cursor = Gdk::Cursor.new(Gdk::Cursor::HAND1)
#    nextEventBox.signal_connect('button_press_event') { cb_play_pause }
#
#    prevEventBox.realize
#    prevEventBox.window.cursor = Gdk::Cursor.new(Gdk::Cursor::HAND1)
#    prevEventBox.signal_connect('button_press_event') {cb_play_pause }
  end
end

trayIcon = MainTrayIcon.new

Gtk.main
