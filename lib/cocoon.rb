#---------------------------------------------------------------------
# Cocoon class
#---------------------------------------------------------------------

class Cocoon < Enemy

  def setup
    super
    @image = Gosu::Image.new("sprites/cocoon/cocoon.png")
    @life = 10.0
  end

  def update
    super
    death($player.cr.cocoons)
    transform(5000,Butterfly,$player.cr.butterflies, $player.cr.cocoons)
    # fire bullet at player if they're in range
    if Gosu.distance(x,y,$player.x, $player.y) < 400
      bullet_emitter.at_player($e_bullets,[x,y],3.0,15.0,Gosu.milliseconds/100)
    else

    end
  end

end
