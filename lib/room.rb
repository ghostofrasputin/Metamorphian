#---------------------------------------------------------------------
# Room class
#---------------------------------------------------------------------

class Room < Chingu::GameObject
  trait :bounding_box
  traits :collision_detection
  attr_reader :defeated, :fake
  attr_accessor :label, :walls, :gates, :food, :caterpillars, :nymphs, :cocoons,
                :butterflies, :dragonflies, :boss

  def setup
    @defeated = false
    @food = []
    @fake = options[:fake]
    @label = options[:label]
    @walls = options[:walls]
    @gates = options[:gates]
    @caterpillars = options[:caterpillars]
    @nymphs = options[:nymphs]
    @cocoons = options[:cocoons]
    @butterflies = options[:butterflies]
    @dragonflies = options[:dragonflies]
    @boss = options[:boss]

    # generate food randomly for now
    for i in 0..100
       f = Food.create(:x=>rand((x-image.width/2)..(x+image.width/2)),
                   :y=>rand((y-image.height/2)..(y+image.height/2)),
                   :zorder => ZOrder::FOOD
       )
       food << f
    end

    # spawn gates
    if !gates.nil?
      gates.each do |g|
        Gate.create(:x=>g[0],:y=>g[1],:zorder=>ZOrder::WALL, :room => self)
      end
    end

    # spawn walls
    if fake.nil?
      spawn_walls
    end

    # spawn caterpillars
    if !caterpillars.nil?
      caterpillars.each do |c|
        Caterpillar.create(:x=>x+c[0],
                            :y=>y+c[1],
                            :zorder=>ZOrder::ENEMY,
                            :food=>food
        )
      end
    end

  end

  def spawn_walls
    # spawn walls all around room except for gate areas
    width = image.width/32
    height = image.height/32
    # top
    temp_x = x - image.width/2 + 16
    temp_y = y - image.height/2 + 16
    for i in 1..width
      if !isGate(temp_x,temp_y)
        Wall.create(:x=> temp_x, :y=>temp_y, :zorder=>ZOrder::WALL)
      end
      temp_x += 32
    end
    # left
    temp_x = x - image.width/2 + 16
    temp_y += 32
    for i in 3..height
      if !isGate(temp_x,temp_y)
        Wall.create(:x=> temp_x, :y=>temp_y, :zorder=>ZOrder::WALL)
      end
      temp_y += 32
    end
    # bottom
    for i in 1..width
      if !isGate(temp_x,temp_y)
        Wall.create(:x=> temp_x, :y=>temp_y, :zorder=>ZOrder::WALL)
      end
      temp_x += 32
    end
    # right
    temp_x -= 32
    temp_y -= 32
    for i in 3..height
      if !isGate(temp_x,temp_y)
        Wall.create(:x=> temp_x, :y=>temp_y, :zorder=>ZOrder::WALL)
      end
      temp_y -= 32
    end
  end

  def isGate(dx,dy)
    if !gates.nil?
      gates.each_with_index do |g,i|
        if g[i] == dx and g[i] == dy
          return true
        end
      end
    end
    return false
  end

end
