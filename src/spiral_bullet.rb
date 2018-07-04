#---------------------------------------------------------------------
# Spiral Bullet class
#---------------------------------------------------------------------

class SpiralBullet < Bullet

  attr_reader :t

  def setup
    super
    @angle = 0.0
    @t = 1.0
  end

  def update
    wall_collision
    @x += t*Math.cos(t)
    @y += t*Math.sin(t)
    @t += speed/(2*Math::PI*t)
  end

end
