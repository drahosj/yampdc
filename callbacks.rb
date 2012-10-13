module Callback
  def cb_play_pause(app, widget = nil)
    if app.mpd.playing?
      app.mpd.pause = true
      puts "Pausing..."

      unless widget == nil
        widget.image = Gtk::Image.new(Gtk::Stock::MEDIA_PLAY, \
                                      Gtk::IconSize::SMALL_TOOLBAR)
      end
    else 
      app.mpd.pause = false
      app.mpd.play
      puts "Playing..."

      unless widget == nil
        widget.image = Gtk::Image.new(Gtk::Stock::MEDIA_PAUSE, \
                                      Gtk::IconSize::SMALL_TOOLBAR)
      end
    end
  end
  def cb_stop(app)
    puts "Stopping..."
    app.mpd.stop
  end
  def cb_next(app)
    puts "Going to next song..."
    app.mpd.next
  end
  def cb_prev(app)
    puts "Going to previous song..."
    app.mpd.next
  end
end
