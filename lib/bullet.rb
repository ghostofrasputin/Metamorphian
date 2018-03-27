#---------------------------------------------------------------------
# Bullet class
#---------------------------------------------------------------------

class Bullet < Chingu::GameObject
  trait :bounding_box
  traits :timer, :collision_detection
  attr_accessor :speed, :angle, :current_room

  def setup
    @image = Gosu::Image.new("sprites/bullets/bullet.png")
    @speed = options[:speed]
    @angle = options[:angle]
    @current_room = nil
  end

  def update
    $player.cr.walls.each do |w|
      if self.bounding_box_collision?(w)
        destroy
      end
    end
    @x += Math.cos(angle)*speed
    @y += Math.sin(angle)*speed
  end

end
