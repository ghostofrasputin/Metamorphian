#---------------------------------------------------------------------
# Map class
#---------------------------------------------------------------------

require 'yaml'

class Map

  attr_reader :rooms, :map, :current_floor

  def initialize
    @current_floor = 1
    @current_room = nil
    @map = Array.new(5) { Array.new(5) }
    @rooms = parse(current_floor)
    generate_floor(rooms)
  end

  def update

  end

  def draw
  end

  def generate_floor(rooms)
    map.each do |row|
      row.each do |col|

      end
    end
  end

  def bfs
  end

  # parses a Yaml file to list of room objects
  def parse(num)
    yml_array = YAML.load_file(File.join(__dir__,"floors/floor"+num.to_s+".yml"))
    count = 1
    rooms = []
    yml_array.each do |table|
      table[count].each do |key, val|
        room = Room.new
        case key
        when "label"
          room.label = val
        when "enemies"
          #puts val
          val.each do |enemy_type, locations|
            case enemy_type
            when "caterpillars"
              locations.each do |loc|
                room.caterpillars << Caterpillar.new(loc[0],loc[1])
              end
            when "nymphs"
            when "cocoons"
            when "dragonflies"
            when "butterflies"
            end
          end
        when "boss"
        when "treasure"
        when "background"
          room.load_image(val)
        else
        end
        rooms << room
      end
      count+=1
    end
    return rooms
  end

end
