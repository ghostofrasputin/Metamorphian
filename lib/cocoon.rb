#---------------------------------------------------------------------
# Cocoon class
#---------------------------------------------------------------------

class Cocoon < Chingu::GameObject
  trait :bounding_box
  traits :collision_detection
  attr_reader :x, :y, :w, :h, :delay, :timer, :bullet_emitter, :life
  attr_accessor :hits

  def setup
    @image = Gosu::Image.new("sprites/cocoon/cocoon.png")
    @bullet_pause = 0.0
    @delay = 15.0
    @timer = 0.0
    @hits = 0.0
    @dead = false
    @life = 5
    @bullet_emitter = BulletEmitter.new
  end

  def update
    frameCount = Gosu.milliseconds/100

    # killed by bullets
    if hits >= life
      @dead = true
    end

    if frameCount > @bullet_pause+delay
      @bullet_pause = frameCount
      @timer += 1
      # transform into butterfly
        if timer == 4
          Butterfly.create(:x=>x,:y=>y,:zorder=>ZOrder::ENEMY)
          destroy
        end
    end

    # fire bullet at player if they're in range
    if (($player.x-x)**2.0+($player.y-y)**2.0)**(0.5) < 400
      bullet_emitter.at_player([],[x,y],3.0,15.0,frameCount)
    else

    end

  end

end
