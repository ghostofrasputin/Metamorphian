#---------------------------------------------------------------------
# Gate class
#---------------------------------------------------------------------

class Gate < Chingu::GameObject
  trait :bounding_box
  traits :collision_detection, :timer
  attr_accessor :type, :room, :level_rooms, :switch, :name

  def setup
    @type = options[:type]
    @switch = false
    @name = ""
    if type == "vertical"
      @name = "sprites/rooms/floor1/v_gate_mask.png"
      @image = Gosu::Image.new(name)
    end
    if type == "horizontal"
      @name = "sprites/rooms/floor1/h_gate_mask.png"
      @image = Gosu::Image.new(name)
    end
  end

  def toggle
    if @switch
      @image = Gosu::Image.new(name)
      @switch = false
    else
      after(400) { @image = Gosu::Image.new("sprites/rooms/floor1/mask.png") }
      @switch = true
    end
  end

end
