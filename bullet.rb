#---------------------------------------------------------------------
# Bullet class
#---------------------------------------------------------------------

class Bullet
  
  attr_reader :speed, :angle_speed
  attr_accessor :x, :y, :angle
  
  def initialize(x,y)
    @image = Gosu::Image.new("graphics/bullet.png")
    @x = x
    @y = y
    @speed = 10.0
    @angle = 0.0
    @angle_speed = 7.0
    @bullet_type = "normal"
  end  
    
  def update
    @y -= speed
    @angle += angle_speed
  end
  
  def draw
    @image.draw_rot(x, y, 1.0, angle)
  end
  
end  