class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    song = self.new
    self.all << song
    song
  end

  def self.new_by_name(name)
    song = self.create
    song.name = name
    song
  end

  # So what is the point of this type of redundancy
  # Unless self.create or new_by_name checks if the song is already created but it is whatever
  def self.create_by_name(name)
    song = self.new_by_name(name)
    self.all << song
    song
  end

  def self.find_by_name(name)
    self.all.find {|song| song.name == name}
  end

  # This works when the condition is set to == nil and not == false... why?
  # I thought in ruby nil and false are both falsey values
  def self.find_or_create_by_name(name)
    if self.find_by_name(name) == nil
      return self.create_by_name(name)
    end
    self.find_by_name(name)
  end

  def self.alphabetical
    self.all.sort_by {|song| song.name}.uniq
  end

  def self.new_from_filename(filename)
    song_info = filename.split(" - ")
    song = self.new
    song.artist_name = song_info[0]
    song.name = song_info[1].split(".mp3")[0]
    song
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    self.all << song
    song
  end

  def self.destroy_all
   @@all = []
  end



end
