#---------------------------------------------------------------------
# Cocoon class
#---------------------------------------------------------------------

class Cocoon < Enemy

  def setup
    super
    @image = Gosu::Image.new("sprites/cocoon/cocoon.png")
    @life = 5.0
    @speed = 0.5
    @rate = rand(0.3..0.4)
  end

  def update
    super
    death($player.cr.cocoons)
    transform(rate,Butterfly,$player.cr.butterflies, $player.cr.cocoons)
    bullet_emitter.circle($e_bullets,[x,y],Gosu.milliseconds/100)
  end

end
