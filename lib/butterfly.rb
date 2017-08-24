#---------------------------------------------------------------------
# Butterfly class
#---------------------------------------------------------------------

class Butterfly
  
  attr_reader :x, :y, :w, :h, :speed, :dead, :wall_step, :life,
              :bullets, :delay, :bullet_emitter
  attr_accessor :hits
  
  def initialize(x,y)
    #@image = Gosu::Image.new("sprites/butterfly/butterfly.png")
    @flapping = Animation.new("sprites/butterfly/wings_flapping_sprite_sheet.png",150,125)
    @x = x
    @y = y
    @w = 150
    @h = 125
    @speed = 0.5
    @dead = false
    @hits = 0.0
    @life = 10.0
    @wall_step = 5.0
    @bullet_emitter = BulletEmitter.new
  end
  
  def update
    frameCount = Gosu.milliseconds/100
    # fire bullet
    bullet_emitter.circle($butterfly_bullets,[x,y],frameCount)
    
    if hits == life
      @dead = true
    end
    
    # boundary collision
    if x > $width 
      @speed*=-1
      @y += wall_step
    elsif x < 0 
      @speed*=-1
      @y += wall_step
    end
    @x += speed
    @y += Math.sin(x/16)
  end
  
  def draw
    #@image.draw_rot(x,y,ZOrder::ENEMY,1.0)
    @flapping.draw(x,y,ZOrder::ENEMY)
  end
  
end