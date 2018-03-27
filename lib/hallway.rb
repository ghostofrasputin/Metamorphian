#---------------------------------------------------------------------
# Hallway class
#---------------------------------------------------------------------

class Hallway < Chingu::GameObject
  trait :bounding_box
  traits :collision_detection

  attr_reader :defeated
  attr_accessor :type, :walls, :gates, :label, :g

  def setup
    @type = options[:type]
    @g = options[:g]
    @label = "hallway"
    @gates = []
    @walls = []
    @defeated = true
    if type == "vertical"
      @image = Gosu::Image.new("sprites/rooms/floor1/v_hallway.png")
      vw = Gosu::Image.new("sprites/rooms/floor1/v_hallway_wall.png")
      walls << Wall.create(:x=>x-image.width/2, :y=>y, :zorder=>ZOrder::WALL, :image=>vw)
      walls << Wall.create(:x=>x+image.width/2, :y=>y, :zorder=>ZOrder::WALL, :image=>vw)
      spawn_gates
    end
    if type == "horizontal"
      @image = Gosu::Image.new("sprites/rooms/floor1/h_hallway.png")
      hw = Gosu::Image.new("sprites/rooms/floor1/h_hallway_wall.png")
      walls << Wall.create(:x=>x, :y=>y+image.height/2,:zorder=>ZOrder::WALL, :image=>hw)
      walls << Wall.create(:x=>x, :y=>y-image.height/2,:zorder=>ZOrder::WALL, :image=>hw)
      spawn_gates
    end
  end

  def spawn_gates
    g.each do |gate|
      gates << Gate.create(:x=>gate[0],:y=> gate[1],:zorder=>ZOrder::GATE, :type => type)
    end
  end

  def any_enemies?
    return false
  end

end
