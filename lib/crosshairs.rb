#---------------------------------------------------------------------
# Crosshairs class
#---------------------------------------------------------------------

class Crosshairs
  
  attr_reader :x, :y
  
  def initialize
    @image = Gosu::Image.new("sprites/crosshairs.png")
    @x = x
    @y = y
  end
  
  def update(x,y)
    @x = x
    @y = y
  end
  
  def draw
    @image.draw_rot(x, y, ZOrder::MOUSE, 0.0)
  end
  
  # option to change image for crosshairs
  # in options
  def set_crosshairs(path)
    @image = Gosu::Image.new(path)
  end
  
end