#---------------------------------------------------------------------
# Room class
#---------------------------------------------------------------------

class Room

  attr_reader :id
  attr_accessor :x, :y, :on, :label, :caterpillars

  def initialize
    @x = 0
    @y = 0
    @w = $width
    @h = $height

    @background_image = nil

    #
    @on = false
    @defeated = false
    @label = ""

    # enemies
    @caterpillars = []
    @cocoons = []
    @butterflys = []
    @nymphs = []
    @dragonflys = []
    @boss = nil

  end

  def update
  end

  def draw
  end

  def load_image(name)
    background_image = Gosu::Image.new("sprites/rooms/floor1/room.png")
  end

end
