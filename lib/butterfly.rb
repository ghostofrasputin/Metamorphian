#---------------------------------------------------------------------
# Butterfly class
#---------------------------------------------------------------------

class Butterfly < Enemy
  attr_reader :animation

  def setup
    super
    @animation = Animation.new("sprites/butterfly/wings_flapping_sprite_sheet.png",150,125)
    @image = @animation.next()
    @speed = 1.0
    @life = 10.0
    @transformable = false
  end

  def update
    super
    @image = @animation.next()
    death($player.cr.butterflies)
    bullet_emitter.rotation($e_bullets,[x,y],Gosu.milliseconds/100)
  end

end
