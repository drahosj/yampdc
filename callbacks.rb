module Callback
  def cb_play_pause(app, playButton = nil)
    if app.mpd.playing?
      app.mpd.pause = true
      puts "Pausing..."
    else 
      app.mpd.pause = false
      app.mpd.play
      puts "Playing..."
    end

    unless playButton == nil
      set_play_button(app, playButton)
    end
  end
  def cb_stop(app, playButton = nil)
    puts "Stopping..."
    app.mpd.stop

    unless playButton == nil
      set_play_button(app, playButton)
    end
  end
  def cb_next(app, playButton = nil)
    puts "Going to next song..."
    app.mpd.next

    unless playButton == nil
      set_play_button(app, playButton)
    end
  end
  def cb_prev(app, playButton = nil)
    puts "Going to previous song..."
    app.mpd.next

    unless playButton == nil
      set_play_button(app, playButton)
    end
  end
  def set_play_button(app, playButton)
    if app.mpd.playing?
      playButton.image = Gtk::Image.new(Gtk::Stock::MEDIA_PAUSE, \
                                        Gtk::IconSize::SMALL_TOOLBAR)
    else
      playButton.image = Gtk::Image.new(Gtk::Stock::MEDIA_PLAY, \
                                        Gtk::IconSize::SMALL_TOOLBAR)
    end
  end
end
