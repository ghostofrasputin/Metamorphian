#---------------------------------------------------------------------
# Bullet class
#---------------------------------------------------------------------

class Bullet
  
  attr_reader :x, :y, :w, :h, :angle, :speed, :out_of_bounds
  
  def initialize(x, y, speed, angle)
    @image = Gosu::Image.new("sprites/bullets/bullet.png")
    @x = x
    @y = y
    @w = @image.width
    @h = @image.height
    @speed = speed
    @angle = angle
    @out_of_bounds = false
  end  
    
  def update
    
    # bullet has gone off screen
    if x < 0 or x > $width or y < 0 or y > $height
      @out_of_bounds = true
      return
    end
    
    @x += Math.cos(angle)*speed
    @y += Math.sin(angle)*speed
  end
  
  def draw
    @image.draw_rot(x, y, ZOrder::BULLETS, angle)
  end
  
end  