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
    if @image == nil
      @image = Gosu::Image.new(name)
      @switch = true
    else
      after(400) { @image = Gosu::Image.new("sprites/rooms/floor1/mask.png") }
      after(400) { @switch = false }
    end
  end

end
