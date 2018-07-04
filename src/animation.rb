#---------------------------------------------------------------------
# Animation class
#---------------------------------------------------------------------

class Animation

  attr_reader :animation

  def initialize(file_location,sprite_w,sprite_h)
    @animation = Gosu::Image.load_tiles(file_location, sprite_w, sprite_h)
  end

  def next
    return @animation[Gosu.milliseconds / 10 % @animation.size]
  end

end
