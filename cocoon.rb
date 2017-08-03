#---------------------------------------------------------------------
# Cocoon class
#---------------------------------------------------------------------

class Cocoon
  
  attr_reader :x, :y, :w, :h, :bullets, :delay
  
  def initialize(x,y)
    @image = Gosu::Image.new("graphics/cocoon.png")
    @x = x
    @y = y
    @w = @image.width
    @h = @image.height
    @bullets = []
    @bulletPause = 0.0
    @delay = 15.0
  end
  
  def update
    frameCount = Gosu.milliseconds/100
    # fire bullet
    if frameCount > @bulletPause+delay
      bullets << Bullet.new(x,y,3.0,"south")
      @bulletPause = frameCount
    end
    bullets.each{|b| b.update}
  end
  
  def draw
    @image.draw_rot(x,y,ZOrder::ENEMY,1.0)
    bullets.each{|b| b.draw}
  end
 
end