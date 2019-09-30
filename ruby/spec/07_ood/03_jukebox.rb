class Disk
  attr_reader :title, :artist

  def initialize(title, artist = nil)
    @title = title
    @artist = artist
  end
end

class JukeBox
  attr_reader :disks

  def initialize(disks)
    @disks = disks
  end

  def play(disk)
    # play it
  end

  def play_random
    play(disks.sample)
  end

  def play_by(title:, artist: nil)
    disk = disks.select do |disk|
      title_match = disk.title.include?(title)
      artist_match = !artist || disk.artist.include?(artist)
      title_match && artist_match
    end

    if disk
      play(disk)
    end
  end
end
