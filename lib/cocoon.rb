#---------------------------------------------------------------------
# Cocoon class
#---------------------------------------------------------------------

class Cocoon
  
  attr_reader :x, :y, :w, :h, :delay, :timer, :bullet_emitter, :life
  attr_accessor :dead, :hits
  
  def initialize(x,y)
    @image = Gosu::Image.new("sprites/cocoon.png")
    @x = x
    @y = y
    @w = @image.width
    @h = @image.height
    @bullet_pause = 0.0
    @delay = 15.0
    @timer = 0.0
    @hits = 0.0
    @dead = false
    @life = 5
    @bullet_emitter = BulletEmitter.new 
  end
  
  def update
    frameCount = Gosu.milliseconds/100
    
    # killed by bullets
    if hits >= life
      @dead = true
    end
    
    if frameCount > @bullet_pause+delay
      @bullet_pause = frameCount
      @timer += 1
      # transform into butterfly
        if timer == 4
          @dead = true
          $butterflies << Butterfly.new(x,y)
          return
        end
    end
    
    # fire bullet at player
    bullet_emitter.at_player($cocoon_bullets,[x,y],3.0,0.0,15.0,frameCount)
    
  end
  
  def draw
    @image.draw_rot(x,y,ZOrder::ENEMY,1.0)
  end
  
end