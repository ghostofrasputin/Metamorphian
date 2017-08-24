#---------------------------------------------------------------------
# Animation class
#---------------------------------------------------------------------

class Animation
  
  def initialize(file_location,sprite_w,sprite_h)
    @animation = Gosu::Image.load_tiles(file_location, sprite_w, sprite_h)
  end
  
  def draw(x,y,z)
    img = @animation[Gosu.milliseconds / 10 % @animation.size]
    img.draw(x - img.width / 2.0, y- img.height / 2.0, z)
  end
  
end