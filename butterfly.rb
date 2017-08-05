#---------------------------------------------------------------------
# Butterfly class
#---------------------------------------------------------------------

require_relative 'butterfly_bullet'

class Butterfly
  
  attr_reader :x, :y, :w, :h, :speed, :alive, :wall_step, :life,
              :bullets, :delay
  attr_accessor :hits
  
  def initialize(x,y)
    @image = Gosu::Image.new("sprites/butterfly.png")
    @x = x
    @y = y
    @w = @image.width
    @h = @image.height
    @speed = 3.0
    @alive = true
    @hits = 0.0
    @life = 10.0
    @wall_step = 5.0
    @bullets = []
    @bullet_pause = 0.0
    @delay = 1.0
  end
  
  def update
    
    frameCount = Gosu.milliseconds/100
    
    # fire bullet
    if frameCount > @bullet_pause+delay
      if bullets.length <= 5
        #bullets << ButterflyBullet.new(x,y)
        @bullet_pause = frameCount
      end
    end
    
    if hits == life
      @alive = false
    end
    
    # boundary collision
    if x > $width 
      @speed*=-1
      @y += wall_step
    elsif x < 0 
      @speed*=-1
      @y += wall_step
    end
    @x += speed
    @y += Math.sin(x/16)
    
    bullets.each{|b| b.update}
  end
  
  def draw
    @image.draw_rot(x,y,ZOrder::BUTTERFLY,1.0)
    bullets.each{|b| b.draw}
  end
  
end