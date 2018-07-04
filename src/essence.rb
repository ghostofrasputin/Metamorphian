#---------------------------------------------------------------------
# Essence class
#---------------------------------------------------------------------

class Essence < Chingu::GameObject
  trait :bounding_box
  traits :collision_detection

  attr_reader :speed

  def setup
    @image = Gosu::Image.new("sprites/essence.png")
    @speed = 0.0005
  end

  def update
    player_collision
    gravitate_to_player
  end

  def player_collision
    if self.bounding_box_collision?($player)
      $player.essence += 1
      $hud.set_essence($player.essence)
      destroy
    end
  end

  def gravitate_to_player
    if !$player.cr.any_enemies?
      if (($player.x-x)**2.0+($player.y-y)**2.0)**(0.5) < 2000
        if $player.x > x
          @x += speed
        end
        if $player.x < x
          @x -= speed
        end
        if $player.y > y
          @y += speed
        end
        if $player.y < y
          @y -= speed
        end
        @speed = @speed*1.1
      end
    end
  end

end
