#---------------------------------------------------------------------
# Caterpillar class
#---------------------------------------------------------------------

class Caterpillar < Enemy

  def setup
    super
    @image = Gosu::Image.new("sprites/caterpillar/caterpillar.png")
    @speed = 1.0
    @life = 5.0
    @span = rand(4000..9000)
  end

  def update
    super
    death($player.cr.caterpillars)
    transform(span,Cocoon,$player.cr.cocoons, $player.cr.caterpillars)
    #bullet_emitter.at_player($e_bullets,[x,y],3.0,15.0,Gosu.milliseconds/100)
    bullet_emitter.helix($e_bullets,[x,y],Gosu.milliseconds/100)
  end

end
