require './ui.rb'
require 'librmpd'

class Application
  attr_reader :mpd
  def initialize
    @mpd = MPD.new()
    mpd.connect
  end
end

app = Application.new
trayIcon = MainTrayIcon.new(app)

Gtk.main
