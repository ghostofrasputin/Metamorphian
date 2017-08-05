#---------------------------------------------------------------------
# Cocoon class
#---------------------------------------------------------------------

class Cocoon
  
  attr_reader :x, :y, :w, :h, :delay, :timer, :bullet_hell
  attr_accessor :alive, :hits
  
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
    @alive = true
    
    @bullet_hell = BulletHell.new
    
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
    
    # fire bullet at player
    bullet_hell.at_player($cocoon_bullets,[x,y],3.0,0.0,15.0,frameCount)
    
    if frameCount > @bullet_pause+delay
      #delta_x = $player.x - x
      #delta_y = $player.y - y
      #angle = Gosu.radians_to_degrees(Math.atan2(delta_y, delta_x))
      #$cocoon_bullets << Bullet.new(x,y,3.0,angle)
      @bullet_pause = frameCount
      @timer += 1
    end
    
  end
  
  def draw
    @image.draw_rot(x,y,ZOrder::ENEMY,1.0)
  end
  
end