#---------------------------------------------------------------------
# Bullet class
#---------------------------------------------------------------------

class Bullet < Chingu::GameObject
  trait :bounding_box
  traits :timer, :collision_detection
  attr_accessor :speed, :angle

  def setup
    @image = Image["sprites/bullets/bullet.png"]
    @speed = options[:speed]
    @angle = options[:angle]
  end

  def update
    @x += Math.cos(angle)*speed
    @y += Math.sin(angle)*speed
    if self.first_collision(Wall)
      destroy
    end
  end

end
