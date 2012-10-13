require 'gtk2'
require './callbacks'

class MainTrayIcon < Gtk::StatusIcon
  include Callback
  def initialize(app)
    super()

    @app = app

    self.stock = Gtk::Stock::MEDIA_PLAY
    self.tooltip = "YAMPDC"
  
    openMainWindow = Gtk::MenuItem.new("Open YAMPDC")
    quit = Gtk::MenuItem.new("Quit")
  
    itemPlay = Gtk::MenuItem.new("Play/Pause")
    itemStop = Gtk::MenuItem.new("Stop")
    itemNext = Gtk::MenuItem.new("Next")
    itemPrev = Gtk::MenuItem.new("Previous")

    itemPlay.signal_connect("activate") {cb_play_pause(@app)}
    itemStop.signal_connect("activate") {cb_stop(@app)}
    itemNext.signal_connect("activate") {cb_next(@app)}
    itemPrev.signal_connect("activate") {cb_prev(@app)}

    quit.signal_connect("activate") { Gtk::main_quit }
    openMainWindow.signal_connect("activate") do
      window = MainWindow.new(@app)
      window.show_all
    end
  
    menu = Gtk::Menu.new
  
    menu.append(itemPlay)
    menu.append(itemStop)
    menu.append(itemNext)
    menu.append(itemPrev)
    menu.append(Gtk::SeparatorMenuItem.new)
    menu.append(openMainWindow)
    menu.append(Gtk::SeparatorMenuItem.new)
    menu.append(quit)
    menu.show_all

    signal_connect("popup-menu") do |tray, button, time|
      menu.popup(nil, nil, button, time)
    end
  
    signal_connect("activate") do
      window = MainWindow.new(@app)
      window.show_all
    end
  end
end

class MainWindow < Gtk::Window
  include Callback
  def initialize(app)
    super()

    @app = app

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
    unless @app.mpd.playing?
      playButton.image = playIcon
    else
      playButton.image = pauseIcon
    end

    stopButton = Gtk::Button.new
    stopButton.image = stopIcon

    nextButton = Gtk::Button.new
    nextButton.image = nextIcon

    prevButton = Gtk::Button.new
    prevButton.image = prevIcon

    playButton.relief = Gtk::RELIEF_NONE
    stopButton.relief = Gtk::RELIEF_NONE
    nextButton.relief = Gtk::RELIEF_NONE
    prevButton.relief = Gtk::RELIEF_NONE

    playButton.signal_connect("clicked"){ |w| cb_play_pause(@app, w)}
    stopButton.signal_connect("clicked") do 
      cb_stop(@app)
      playButton.image = playIcon
    end
    nextButton.signal_connect("clicked") do
      cb_next(@app)
      playButton.image = pauseIcon
    end
    prevButton.signal_connect("clicked") do 
      cb_prev(@app)
      playButton.image = pauseIcon
    end

    controlBox.pack_start(prevButton, false, false, 0)
    controlBox.pack_start(playButton, false, false, 0)
    controlBox.pack_start(stopButton, false, false, 0)
    controlBox.pack_start(nextButton, false, false, 0)

    mainVBox.pack_start(controlAlignment, false, false, 0)
    mainVBox.pack_start(Gtk::HSeparator.new, false, false, 0)

    add(mainVBox)
  end
end
