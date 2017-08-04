#---------------------------------------------------------------------
# Butterfly class
#---------------------------------------------------------------------

class Butterfly
  
  attr_reader :x, :y, :w, :h, :speed, :alive, :wall_step, :life
  attr_accessor :hits
  
  def initialize(x,y)
    @image = Gosu::Image.new("sprites/butterfly.png")
    @x = x
    @y = y
    @w = @image.width
    @h = @image.height
    @speed = 3
    @alive = true
    @hits = 0
    @life = 10
    @wall_step = 5
  end
  
  def update
    
    if hits == life
      @alive = false
    end
    
    # boundary collision
    if x > $width 
      @speed*=-1
      @y += wall_step
    elsif x < 0 
      @speed*=-1
      @y += wall_step
    end
    #elsif y > $height
    #  @speed*=-1
    #elsif y < 0
    #  @speed*=-1
    #end
    @x += speed
    @y += Math.sin(x/16)
  end
  
  def draw
    @image.draw_rot(x,y,ZOrder::BUTTERFLY,1.0)
  end
  
end