#---------------------------------------------------------------------
# Bullet Emitter class
#   contains an assortment of Bullet Hell patterns
#---------------------------------------------------------------------

require_relative 'bullet'

class BulletEmitter
  
  attr_reader :bullet_pause
  
  def initialize
    @bullet_pause = 0.0
  end
  
  def line(list, loc, speed, angle, frequency, frameCount)
    if frameCount > @bullet_pause+frequency
      $sm.play_sound("laser",0.3,1.0,false)
      x = loc[0]
      y = loc[1]
      list << Bullet.new(x, y, speed, angle)
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
      list << Bullet.new(x, y, speed, angle)
      @bullet_pause = frameCount
    end
  end
  
  def circle(list, loc, speed, angle, frequency, frameCount)
    if frameCount > @bullet_pause+frequency
      x = loc[0]
      y = loc[1]
      for i in 1..18
        angle += 20
        list << Bullet.new(x, y, speed, angle)
      end
      @bullet_pause = frameCount
    end
  end
  
  def bouncing_circles
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