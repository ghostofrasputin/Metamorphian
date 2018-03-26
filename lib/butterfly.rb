#---------------------------------------------------------------------
# Butterfly class
#---------------------------------------------------------------------

class Butterfly < Chingu::GameObject
  trait :bounding_box
  traits :collision_detection
  attr_reader :speed, :wall_step, :life, :bullets, :delay, :bullet_emitter
  attr_accessor :hits

  def setup
    @image = Gosu::Image.new("sprites/butterfly/butterfly.png")
    @speed = 0.5
    @hits = 0.0
    @life = 10.0
    @wall_step = 5.0
    @bullet_emitter = BulletEmitter.new
  end

  def update
    # fire bullet
    bullet_emitter.spiral([],[x,y],Gosu.milliseconds/100)

    if hits == life
      destroy
    end

    # boundary collision
    @x += speed
    @y += Math.sin(x/16)
  end

end
