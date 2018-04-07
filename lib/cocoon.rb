#---------------------------------------------------------------------
# Cocoon class
#---------------------------------------------------------------------

class Cocoon < Enemy

  def setup
    super
    @image = Gosu::Image.new("sprites/cocoon/cocoon.png")
    @life = 5.0
    @speed = 0.5
    @span = rand(6000..9000)
  end

  def update
    super
    death($player.cr.cocoons)
    transform(span,Butterfly,$player.cr.butterflies, $player.cr.cocoons)
    bullet_emitter.circle($e_bullets,[x,y],Gosu.milliseconds/100)
  end

end
