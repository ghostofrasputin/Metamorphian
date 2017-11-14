#---------------------------------------------------------------------
# Room class
#---------------------------------------------------------------------

class Room
  
  attr_reader :id
  attr_accessor :x, :y, :on
  
  def initialize(id)
    @x = nil
    @y = nil
    @w = nil
    @h = nil
    
    @id = id
    @waves = waves
    @background_image = Gosu::Image.new("sprites/rooms/floor1/room.png")
    
    # 
    @on = false
    @defeated = false
    
    @caterpillars = []
    @cocoons = []
    @butterflys = []
    @nymphs = []
    @dragonflys = []
    @boss = []
    
    @w1 = {}
    @w2 = {}
    @w3 = {}
    
    @waves = [w1]
    
    @current_wave = 1
    
  end
  
  def update
    if on
      # raise_walls
      
      
      if id == "boss"
        if boss.empty?
          
        end
      elsif id == "treasure"
      elsif id == "bizarre"
      # normal enemy room
      else
        wave_hash = waves[current_wave]
        wave_hash.each do |key, enemy_array|
          # game logic goes here
        end
        # if all arrays are empty in hash then start the next wave
        #   current_wave++
        #   if waves.length == current_wave
        #     defeated = true
        #   end
        # end
      end
    end
    
    if defeated
      # lower_walls
      on = false
    end
    
    # below is for default room updates and logic (like idle animations, wall collisions)
  end
  
  def draw
    
  end
  
  def player_is_in_room(player)
    if rect_collision(player, [x,y,w,h])
      on = true
    end
  end
  
end