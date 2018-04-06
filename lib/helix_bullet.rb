#---------------------------------------------------------------------
# Helix Bullet class
#   Inherits from the bullet class, but it's angle is no longer
#   constant. Bullets move in a sine wave pattern to mimic the
#   the shape of helixcal 2D DNA. The flag parameter starts the wave
#   in a positive or negative amplitude, so when 2 bullets are
#   created they travel together opposingly along the y-axis.
#---------------------------------------------------------------------

class HelixBullet < Bullet

  attr_reader :flag, :amplitude

  def setup
    super
    @flag = options[:flag]
    @amplitude = 0.3 # very fragile
  end

  def update
    wall_collision

    @y += Math.sin(Gosu.degrees_to_radians(angle))*speed
    if flag
      @x += Math.cos(Gosu.degrees_to_radians(y/amplitude))*speed
    else
      @x -= Math.cos(Gosu.degrees_to_radians(y/amplitude))*speed
    end
  end

end
