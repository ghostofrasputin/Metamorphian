#---------------------------------------------------------------------
# Map class
#   parses yaml level files, stores room data for procedurally
#   generated levels based on pre-defined rooms
#---------------------------------------------------------------------

require 'yaml'

# temporarily stores room data for Room object to use
# during the generate_floor function
class RoomData
  attr_accessor :label, :food, :walls, :gates, :caterpillars, :nymphs, :cocoons,
    :butterflies, :dragonflies, :boss, :room_background
end

class Map

  attr_reader :rooms, :current_floor, :starting_room
  attr_accessor :level_rooms, :map

  def initialize
    @current_floor = 1
    @starting_room = nil
    @level_rooms = []
    @map = Array.new(5) { Array.new(5) }
    @rooms = parse(current_floor)
    generate_floor(rooms)

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
    # generate initial path
    nodes = []
    while nodes == []
      map.each_with_index do |row, i|
        row.each_with_index do |col , j|
          if not (i == goalx and j == goaly)
            if rand < 0.5
              map[i][j] = 'W'
            else
              map[i][j] = '#'
            end
          end
        end
      end
      nodes = bfs([startx,starty], [goalx,goaly])
      if nodes == []
        @map = Array.new(5) { Array.new(5) }
      end
      # the path is built with
      # enemy rooms so if the path exceeds that
      # than there's no rooms to build the path with
      if nodes.length > rooms.length - 2
        @map = Array.new(5) { Array.new(5) }
        nodes = []
      end
    end
    # add rooms to path
    offset = 600
    nodes.each do |node|
       i = (node[0]*800)+offset
       j = (node[1]*800)+offset
       rd = random_room(rooms, false)
       level_rooms << Room.create(
         :x => j,
         :y => i,
         :zorder => ZOrder::ROOM,
         :gates => nil,
         :label => rd.label,
         :caterpillars => rd.caterpillars,
         :nymphs => rd.nymphs,
         :cocoons => rd.cocoons,
         :butterflies => rd.butterflies,
         :dragonflies => rd.dragonflies,
         :boss => rd.boss,
         :image => Gosu::Image.new(rd.room_background)
       )
       map[node[0]][node[1]] = 'R'
    end
    # add ony extra rooms to the path
    map.each_with_index do |row, i|
      row.each_with_index do |col , j|
        if map[i][j] == 'W' or map[i][j] == '#'
          successors = successor([i,j])
          #puts successors.inspect
          if !successors.empty?
            successors.each do |s|
              if map[s[0]][s[1]] == 'R' and rooms.length > 0
                rx = (j*800)+offset
                ry = (i*800)+offset
                rd = random_room(rooms, true)
                r = Room.create(
                  :x => rx,
                  :y => ry,
                  :zorder => ZOrder::ROOM,
                  :label => rd.label,
                  :gates => nil,
                  :caterpillars => rd.caterpillars,
                  :nymphs => rd.nymphs,
                  :cocoons => rd.cocoons,
                  :butterflies => rd.butterflies,
                  :dragonflies => rd.dragonflies,
                  :boss => rd.boss,
                  :image => Gosu::Image.new(rd.room_background)
                )
                level_rooms << r
                if rd.label == "start"
                  map[i][j] = 'S'
                  $player = Player.create(:x => rx,
                                          :y => ry,
                                          :zorder => ZOrder::PLAYER,
                                          :cr => r,
                                          :rooms => level_rooms
                  )
                elsif rd.label == "boss"
                  map[i][j] = 'B'
                else
                  map[i][j] = 'R'
                end
                break
              end
            end
          end
        end
      end
    end

    # Debug: print out map
    #print_map

  end

  def random_room(rooms, flag)
    while true
      r = rooms.sample
      if r.label != "boss" and r.label != "start" or flag
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

  # breadth first search
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
      successors = successor(node)
      if !successors.empty?
        successors.each do |s|
          if not set.include? s
            new_path = [].replace(path) << node
            state = [s,new_path]
            set << s
            queue.unshift(state)
          end
        end
      end
    end
    return []
  end

  # parses a Yaml file to list of room objects
  def parse(num)
    yml_array = YAML.load_file(File.join(__dir__,"floors/floor"+num.to_s+".yml"))
    count = 1
    rooms = []
    yml_array.each do |table|
      rd = RoomData.new
      table[count].each do |key, val|
        case key
        when "label"
          rd.label = val
        when "enemies"
          val.each do |enemy_type, locations|
            case enemy_type
            when "caterpillars"
              rd.caterpillars = locations
            when "nymphs"
              rd.nymphs = locations
            when "cocoons"
              rd.cocoons = locations
            when "dragonflies"
              rd.dragonflies = locations
            when "butterflies"
              rd.butterflies = locations
            end
          end
        when "boss"
          rd.boss = val
        when "background"
          rd.room_background = val
        else
        end
      end
      rooms << rd
      count+=1
    end
    return rooms
  end

  # print out map layout
  def print_map
    map.each_with_index do |row, i|
      row.each_with_index do |col , j|
        #puts col
        if col == 'R'
          print 'R'
        elsif col == 'S'
          print 'S'
        elsif col == 'B'
          print 'B'
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
