#---------------------------------------------------------------------
# Bullet class
#---------------------------------------------------------------------

class Bullet
  
  attr_reader :x, :y
  
  def initialize(x,y)
    @image = Gosu::Image.new("graphics/starfighter.bmp")
    @x=x
    @y=y
    @speed = 4
  end  
    
  def update
    @y-=@speed
  end
  
  def draw
    @image.draw_rot(@x, @y, 1, 0.0)
  end
  
end  