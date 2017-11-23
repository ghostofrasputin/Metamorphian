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
    startx = 0
    starty = 0
    goalx = 0
    goaly = 0
    if rand < 0.5
      # top or bottom area
      startx = rand < 0.5 ? 1 : 3
      starty = rand < 0.5 ? 0 : 4
      goalx = rand < 0.5 ? 1 : 3
      goaly = starty == 4 ? 0 : 4
    else
      # left or right area
      startx = rand < 0.5 ? 0 : 4
      starty = rand < 0.5 ? 1 : 3
      goalx = startx == 4 ? 0 : 4
      goaly = rand < 0.5 ? 1 : 3
    end

    # fill map with random walls
    map.each_with_index do |row, i|
      row.each_with_index do |col , j|
        if not (i == goalx and j == goaly)
          if rand < 0.3
            map[i][j] = 'W'
          end
        end
      end
    end

    # add room layout to map
    nodes = bfs([startx,starty], [goalx,goaly])
    nodes.each do |node|
      i = node[0]
      j = node[1]
      if i == startx and j == starty
      elsif i == goalx and j == goaly
      else
        map[i][j] = random_room(rooms)
      end
    end

    print_map

  end

  def random_room(rooms)
    while true
      r = rooms.sample
      if not r.label == "boss"
        rooms.delete(r)
        return r
      end
    end
  end

  def successor(node)
    successors = []
    i = node[0]
    j = node[1]
    if i != 0
      successors << [i-1,j]
    end
    if j != 0
      successors << [i,j-1]
    end
    if i != 4
      successors << [i+1,j]
    end
    if j != 4
      successors << [i,j+1]
    end
    return successors.delete_if {|n| map[n[0]][n[1]] == 'W'}
  end

  def bfs(start, goal)
    set = []
    queue = []
    queue.unshift([start, []])
    while queue.length>0
      current = queue.pop
      node = current[0]
      path = current[1]
      if node[0] == goal[0] and node[1] == goal[1]
        return path << node
      end
      successor(node).each do |s|
        if not set.include? s
          new_path = [].replace(path) << node
          state = [s,new_path]
          set << s
          queue.unshift(state)
        end
      end
    end
    puts "no path"
    return []
  end

  # parses a Yaml file to list of room objects
  def parse(num)
    yml_array = YAML.load_file(File.join(__dir__,"floors/floor"+num.to_s+".yml"))
    count = 1
    rooms = []
    yml_array.each do |table|
      room = Room.new
      table[count].each do |key, val|
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
      end
      rooms << room
      count+=1
    end
    return rooms
  end

  # print out map layout
  def print_map
    map.each_with_index do |row, i|
      row.each_with_index do |col , j|
        #puts col
        if col.is_a? Room
          print 'R'
        elsif col == 'W'
          print 'W'
        else
          print '#'
        end
      end
      puts ''
    end
  end

end
