#---------------------------------------------------------------------
# Cocoon class
#---------------------------------------------------------------------

class Cocoon
  
  attr_reader :x, :y, :w, :h, :bullets, :delay, :timer
  attr_accessor :alive, :hits
  
  def initialize(x,y)
    @image = Gosu::Image.new("sprites/cocoon.png")
    @x = x
    @y = y
    @w = @image.width
    @h = @image.height
    @bullets = []
    @bulletPause = 0.0
    @delay = 15.0
    @timer = 0.0
    @hits = 0.0
    @alive = true
  end
  
  def update
    frameCount = Gosu.milliseconds/100
    
    # transform into butterfly
    if timer == 5
      @alive = false
      $butterflies << Butterfly.new(x,y)
    end
    
    # killed by bullets
    if hits >= 5
      @alive = false
    end
    
    # fire bullet
    if frameCount > @bulletPause+delay
      bullets << Bullet.new(x,y,3.0,"south")
      @bulletPause = frameCount
      @timer += 1
    end
    
    bullets.each{|b| b.update}
  end
  
  def draw
    @image.draw_rot(x,y,ZOrder::ENEMY,1.0)
    bullets.each{|b| b.draw}
  end
  
end