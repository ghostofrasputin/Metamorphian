#---------------------------------------------------------------------
# Bullet class
#---------------------------------------------------------------------

class Bullet < Chingu::GameObject
  trait :bounding_box
  traits :timer, :collision_detection
  attr_accessor :speed, :angle, :current_room, :gate_flag, :list

  def setup
    @image = Gosu::Image.new("sprites/bullets/bullet.png")
    @speed = options[:speed]
    @angle = options[:angle]
    @list = options[:list]
    @current_room = nil
    @gate_flag = false
  end

  def update
    # check current rooms wall collisions
    $player.cr.walls.each do |w|
     if self.bounding_box_collision?(w) and !$player.gate_collision?(self)
       die
     end
    end

    # check neighboring hallway wall collisions
    if $player.cr.label != "hallway" and $player.cr.defeated
      $player.cr.hallways.each do |h|
        h.walls.each do |w|
          if self.bounding_box_collision?(w)
            die
          end
        end
      end
    end

    # destroy bullets that go too far
    if Gosu.distance(x,y,$player.x,$player.y) > 500
      die
    end

    # Debug
    #puts $p_bullets.length

    @x += Math.cos(angle)*speed
    @y += Math.sin(angle)*speed
  end

  def die
    list.delete(self)
    destroy
  end

end
