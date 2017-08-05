#---------------------------------------------------------------------
# Bullet Hell class
#   contains an assortment of Bullet Hell patterns
#---------------------------------------------------------------------

require_relative 'bullet'
require_relative 'bullet_emitter'

class BulletHell
  
  attr_reader :bullet_pause
  
  def initialize
    @bullet_pause = 0.0
  end
  
  def line(list, loc, speed, angle, frequency, frameCount)
    if frameCount > @bullet_pause+frequency
      list << Bullet.new(loc[0], loc[1], speed, angle)
      @bullet_pause = frameCount
    end  
  end
  
  def at_player(list, loc, speed, angle, frequency, frameCount)
    if frameCount > @bullet_pause+frequency
      x = loc[0]
      y = loc[1]
      delta_x = $player.x - x
      delta_y = $player.y - y
      angle = Gosu.radians_to_degrees(Math.atan2(delta_y, delta_x))
      list << Bullet.new(x,y,3.0,angle)
      @bullet_pause = frameCount
    end
  end
  
  def circle(list)
  end
  
  def flower(list)
  end
  
  def spiral(list)
  end
  
  def slither(list)
  end
  
  def helix(list)
  end
  
end