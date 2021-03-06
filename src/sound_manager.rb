#---------------------------------------------------------------------
# Sound Manager class
#   loads and plays sfx/music
#---------------------------------------------------------------------

class SoundManager

  attr_reader :sound_library

  def initialize
    # load all music here
    @sound_library = {}
    # music
    sound_library["everglades"] =  Gosu::Sample.new("music/moonlight-on-the-everglades.wav")
    sound_library["synth_melody"] = Gosu::Sample.new("music/bass-melody.wav")
    # sfx
    sound_library["laser"] = Gosu::Sample.new("sfx/laser1.wav")
    sound_library["error"] = Gosu::Sample.new("sfx/error.wav")
    sound_library["regain1"] = Gosu::Sample.new("sfx/regain1.wav")
    sound_library["chest_open"] = Gosu::Sample.new("sfx/chest_open.wav")
    sound_library["machine_gun"] = Gosu::Sample.new("sfx/zap.wav")
    sound_library["circle"] = Gosu::Sample.new("sfx/laser2.wav")
    sound_library["spiral"] = Gosu::Sample.new("sfx/laser3.wav")
  end

  def play_sound(name, volume, speed, looping)
    if sound_library.has_key?(name)
      sound_library[name].play(volume, speed, looping)
    else
      abort("Error: the song '" + name+ "' does not exist in the sound library")
    end
  end

  def play_sample(name)
  end

end
