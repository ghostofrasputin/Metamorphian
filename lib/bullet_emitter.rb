#---------------------------------------------------------------------
# Bullet Emitter class
#   contains an assortment of Bullet Hell patterns
#---------------------------------------------------------------------

require_relative 'bullet'
require_relative 'helix_bullet'

class BulletEmitter
  
  attr_reader :bullet_pause, :spiral_angles
  
  def initialize
    @bullet_pause = 0.0
    @spiral_angles = [0.0, 180.0]
  end
  
  def line(list, loc, speed, angle, frequency, frameCount)
    if frameCount > @bullet_pause+frequency
      #$sm.play_sound("laser",0.3,1.0,false)
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
      angle = Math.atan2(delta_y, delta_x)
      list << Bullet.new(x, y, speed, angle)
      @bullet_pause = frameCount
    end
  end
  
  def at_mouse(list, loc, speed, angle, frequency, frameCount)
    if frameCount > @bullet_pause+frequency
      $sm.play_sound("laser",0.3,1.0,false)
      x = loc[0]
      y = loc[1]
      delta_x = $crosshairs.x - x
      delta_y = $crosshairs.y - y
      angle = Math.atan2(delta_y, delta_x)
      list << Bullet.new(x, y, speed, angle)
      @bullet_pause = frameCount
    end
  end
  
  # divsor should only be a factor of 360
  # the higher the factor the more compact the circle
  # 1,2,3,4,5,6,8,9,10,12,15,18,20,24,30,36,40,45,60,72,90,120,180,360
  def circle(list, loc, frameCount, divisor=18, speed=4.0, frequency=50.0)
    if frameCount > @bullet_pause+frequency
      x = loc[0]
      y = loc[1]
      angle = 0.0
      degree = 360.0/divisor
      for i in 1..divisor
        angle += degree
        list << Bullet.new(x, y, speed, Gosu.degrees_to_radians(angle))
      end
      @bullet_pause = frameCount
    end
  end
  
  def rotating_circles(list)
  end
  
  def bouncing_circles(list)
  end
  
  def flower(list)
  end
  
  def spiral(list, loc, frameCount, degree_shift=10.0, speed=4.0, frequency=0.0)
    if frameCount > @bullet_pause+frequency
      x = loc[0]
      y = loc[1]
      list << Bullet.new(x, y, speed, Gosu.degrees_to_radians(spiral_angles[0]))
      @spiral_angles[0] += degree_shift % 360
      @bullet_pause = frameCount
    end
  end
  
  def double_spiral(list, loc, frameCount, degree_shift=10.0, speed=4.0, frequency=0.0)
    if frameCount > @bullet_pause+frequency
      x = loc[0]
      y = loc[1]
      list << Bullet.new(x, y, speed, Gosu.degrees_to_radians(spiral_angles[0]))
      list << Bullet.new(x, y, speed, Gosu.degrees_to_radians(spiral_angles[1]))
      @spiral_angles[0] += degree_shift % 360
      @spiral_angles[1] += degree_shift % 360
      @bullet_pause = frameCount
    end
  end
  
  def slither(list)
  end
  
  def snake_game(list)
  end
  
  def helix(list, loc, frameCount, speed=2.0, angle=-270.0, frequency=0.0)
    if frameCount > @bullet_pause+frequency
      x = loc[0]
      y = loc[1]
      pos = HelixBullet.new(x, y, speed, angle, true)
      neg = HelixBullet.new(x, y, speed, angle, false)
      list << pos << neg
      @bullet_pause = frameCount
    end
  end
  
end