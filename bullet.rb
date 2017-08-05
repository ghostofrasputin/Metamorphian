#---------------------------------------------------------------------
# Bullet class
#---------------------------------------------------------------------

class Bullet
  
  attr_reader :x, :y, :w, :h, :angle, :speed
  
  def initialize(x, y, speed, angle)
    @image = Gosu::Image.new("sprites/bullet.png")
    @x = x
    @y = y
    @w = @image.width
    @h = @image.height
    @speed = speed
    @angle = angle
  end  
    
  def update
    @x += Math.cos(Gosu.degrees_to_radians(angle))*speed
    @y += Math.sin(Gosu.degrees_to_radians(angle))*speed
  end
  
  def draw
    @image.draw_rot(x, y, ZOrder::BULLETS, angle)
  end
  
end  