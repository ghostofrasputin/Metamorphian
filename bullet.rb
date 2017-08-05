#---------------------------------------------------------------------
# Bullet class
#---------------------------------------------------------------------

class Bullet
  
  attr_reader :x, :y, :w, :h, :angle, :speed, :out_of_bounds
  
  def initialize(x, y, speed, angle)
    @image = Gosu::Image.new("sprites/bullet.png")
    @x = x
    @y = y
    @w = @image.width
    @h = @image.height
    @speed = speed
    @angle = angle
    @out_of_bounds = false
  end  
    
  def update
    if x < 0 || x > $width || y < 0 || y > $height
      @out_of_bounds = true
    end
    
    @x += Math.cos(Gosu.degrees_to_radians(angle))*speed
    @y += Math.sin(Gosu.degrees_to_radians(angle))*speed
  end
  
  def draw
    @image.draw_rot(x, y, ZOrder::BULLETS, angle)
  end
  
end  