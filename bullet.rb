#---------------------------------------------------------------------
# Bullet class
#---------------------------------------------------------------------

class Bullet
  
  attr_reader :speed, :angle_speed, :dir
  attr_accessor :x, :y, :w, :h, :angle
  
  def initialize(x,y,speed,dir)
    @image = Gosu::Image.new("sprites/bullet.png")
    @x = x
    @y = y
    @w = @image.width
    @h = @image.height
    @speed = speed
    @angle = 0.0
    @angle_speed = 7.0
    @dir = dir
    @bullet_type = "normal"
  end  
    
  def update
    if dir=="north"
      @y -= speed
      @angle += angle_speed
    elsif dir == "south"
      @y += speed
    end  
  end
  
  def draw
    @image.draw_rot(x, y, ZOrder::BULLETS, angle)
  end
  
end  