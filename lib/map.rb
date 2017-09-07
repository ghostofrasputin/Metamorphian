#---------------------------------------------------------------------
# Map class
#---------------------------------------------------------------------

class Map
  
  attr_reader :rooms
  
  def initialize(x,y)
    @floor_hash = {
      1 => method(:floor1),
      2 => method(:floor2),
      3 => method(:floor3)
    }
    @current_floor = 1
    @rooms = generate_floor(floor_hash[current_floor].())
  end
  
  def update
    #if room == boss room and boos is dead
    # load Screen
    # @current_floor+=1
    # rooms = generate_floor(floor_hash[current_floor].call)
  end
  
  def draw
  end
  
  def mini_map
    
  end
  
  def generate_floor(floor)
  end
  
  # pre-defined rooms for floor 1
  def floor1
    floor1 = []
    room1 = Room.new
    room2 = Room.new
    room3 = Room.new
    room4 = Room.new
    room5 = Room.new
    room6 = Room.new
    room7 = Room.new
    room8 = Room.new
    room9 = Room.new
    room10 = Room.new
    return floor1
  end
  
  def floor2
  end
  
  def floor3
  end
  
end
