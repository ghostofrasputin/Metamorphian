#---------------------------------------------------------------------
# Butterfly class
#---------------------------------------------------------------------

class Butterfly < Chingu::GameObject
  trait :bounding_box
  traits :collision_detection
  attr_reader :speed, :wall_step, :life, :bullets, :delay, :bullet_emitter
  attr_accessor :hits, :animation

  def setup
    #@image = Gosu::Image.new("sprites/butterfly/butterfly.png")
    @animation = Animation.new("sprites/butterfly/wings_flapping_sprite_sheet.png",150,125)

    # Start out by animation frames 0-5 (contained by @animations[:scan])
    @speed = 0.5
    @hits = 0.0
    @life = 10.0
    @wall_step = 5.0
    @bullet_emitter = BulletEmitter.new
  end

  def update
    @image = @animation.next()

    # fire bullet
    bullet_emitter.spiral($e_bullets,[x,y],Gosu.milliseconds/100)

    # player bullet collision
    $p_bullets.delete_if do |b|
      if self.bounding_box_collision?(b)
        @hits += 1.0
        b.destroy
        true
      end
    end

    # dead
    if hits == life
      $player.cr.butterflies.pop()
      destroy
    end

    # move towards player
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
