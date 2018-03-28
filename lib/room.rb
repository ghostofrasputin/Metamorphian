#---------------------------------------------------------------------
# Room class
#---------------------------------------------------------------------

class Room < Chingu::GameObject
  trait :bounding_box
  traits :collision_detection
  attr_reader :defeated, :fake, :lock, :key, :flag
  attr_accessor :label, :walls, :gates, :food, :caterpillars, :nymphs, :cocoons,
                :butterflies, :dragonflies, :boss, :enemies, :hallways

  def setup
    @lock = false
    @defeated = false
    @food = []
    @walls = []
    @gates = []
    @hallways = []
    @fake = options[:fake]
    @key = options[:key]
    @flag = options[:flag]
    @label = options[:label]
    @caterpillars = options[:caterpillars] || []
    @nymphs = options[:nymphs] || []
    @cocoons = options[:cocoons] || []
    @butterflies = options[:butterflies] || []
    @dragonflies = options[:dragonflies] || []
    @boss = options[:boss]
    @enemies = [caterpillars, cocoons, butterflies, dragonflies]

    if label == "start" or label == "treasure" or label == "boss"
      @defeated = true
    end

    # generate food randomly for now
    for i in 0..20
       food << Food.create(:x=>rand((x-image.width/2+64)..(x+image.width/2-64)),
                   :y=>rand((y-image.height/2+64)..(y+image.height/2-64)),
                   :zorder => ZOrder::FOOD
       )
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

  end

  def update

    # lock gates and spawn enemies as player enters the room
    if !defeated and !lock and $player.cr.label == label
      activate_gates()
      spawn_enemies()
      @lock = true
    end

    # open gates when all enemies are gone
    if !defeated and lock
      # puts enemies.inspect # good for debugging current room
      if !any_enemies?
        activate_gates()
        @defeated = true
      end
    end

  end

  def activate_gates
    gates.each do |g|
      g.toggle()
    end
  end

  def spawn_enemies
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

  def any_enemies?
    enemies.each do |e|
      if !e.nil?
        if e != []
          return true
        end
      end
    end
    return false
  end

end
