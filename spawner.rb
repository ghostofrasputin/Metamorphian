#---------------------------------------------------------------------
# Spawner class
#---------------------------------------------------------------------

class Spawner
  
  attr_reader :x, :y, :delay
  
  def initialize
    @x = 0
    @y = -20
    @w = $width
    @caterpillar_spawn_time = 0.0
    @caterpillar_limit = 0.0
    @delay = 10
  end
  
  def update
    frameCount = Gosu.milliseconds/100
    if @caterpillar_limit <= 10
      if frameCount > @caterpillar_spawn_time+delay
        $caterpillars << Caterpillar.new(rand(x..$width),y)
        @caterpillar_limit += 1
        @caterpillar_spawn_time = frameCount
      end
    else 
      # wait till everything is cleared, then start next wave
    end
  end
  
end