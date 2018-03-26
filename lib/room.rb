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
    @walls = []
    @fake = options[:fake]
    @label = options[:label]
    @gates = options[:gates]
    @caterpillars = options[:caterpillars]
    @nymphs = options[:nymphs]
    @cocoons = options[:cocoons]
    @butterflies = options[:butterflies]
    @dragonflies = options[:dragonflies]
    @boss = options[:boss]

    # generate food randomly for now
    for i in 0..20
       food << Food.create(:x=>rand((x-image.width/2+64)..(x+image.width/2-64)),
                   :y=>rand((y-image.height/2+64)..(y+image.height/2-64)),
                   :zorder => ZOrder::FOOD
       )
    end

    # spawn gates
    if !gates.nil?
      gates.each do |g|
        Gate.create(:x=>g[0],:y=>g[1],:zorder=>ZOrder::WALL, :room => self)
      end
    end

    # spawn walls, each room has 4 main walls,
    # plus optional yaml file obstacle walls
    if fake.nil?
      h = Gosu::Image.new("sprites/rooms/floor1/horizontal.png")
      v = Gosu::Image.new("sprites/rooms/floor1/vertical.png")
      walls << Wall.create(:x=> x-width/2+16, :y=>y, :zorder=>ZOrder::WALL, :image => v)
      walls << Wall.create(:x=> x+width/2-16, :y=>y, :zorder=>ZOrder::WALL, :image => v)
      walls << Wall.create(:x=> x, :y=>y-width/2+16, :zorder=>ZOrder::WALL, :image => h)
      walls << Wall.create(:x=> x, :y=>y+width/2-16, :zorder=>ZOrder::WALL, :image => h)
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

  def update

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
