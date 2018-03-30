#---------------------------------------------------------------------
# Butterfly class
#---------------------------------------------------------------------

class Butterfly < Enemy
  attr_reader :animation

  def setup
    super
    @animation = Animation.new("sprites/butterfly/wings_flapping_sprite_sheet.png",150,125)
    @image = @animation.next()
    @speed = 0.5
    @life = 10.0
  end

  def update
    super
    @image = @animation.next()
    death($player.cr.butterflies)
    bullet_emitter.spiral($e_bullets,[x,y],Gosu.milliseconds/100)
    move
  end

  def move
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
  end

end
