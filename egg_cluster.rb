#---------------------------------------------------------------------
# Egg Cluster class
#---------------------------------------------------------------------

class EggCluster
  
  attr_reader :x, :y, :scale, :scale_factor, :delay
  
  def initialize(x,y)
    @image = Gosu::Image.new("graphics/egg_cluster.png")
    @x = x
    @y = y
    @caterpillar_spawn_time = 0.0
    @scale = 1.0
    @scale_factor = 0.002
    @flip = true
    @delay = 30
  end
  
  def update(caterpillars, food)
    frameCount = Gosu.milliseconds/100
    if frameCount > @caterpillar_spawn_time+delay
      caterpillars << Caterpillar.new(x,y,food)
      @caterpillar_spawn_time = frameCount
    end
    
    # egg pulse behavior:
    if @flip
      @scale += scale_factor
      if scale >= 1.1
        #puts "here"
        @flip = false
      end
    else
      @scale -= scale_factor
      if scale <= 1.0
        @flip = true
      end
    end
    
  end
  
  def draw
    @image.draw(@x+scale, @y+scale, 1.0, scale_x = scale, scale_y = scale)
  end
  
end