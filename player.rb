#---------------------------------------------------------------------
# Player class
#---------------------------------------------------------------------

class Player
    
  def initialize(x, y)
    @image = Gosu::Image.new("graphics/starfighter.bmp")
    @x = x
    @y = y
    @speed = 3.0
    @angle = 0.0
  end    
  
  def update
    if Gosu.button_down? Gosu::char_to_button_id('A')
      @x-=@speed
    end
    if Gosu.button_down? Gosu::char_to_button_id('D')
      @x+=@speed
    end
    if Gosu.button_down? Gosu::char_to_button_id('W')
      @y-=@speed
    end
    if Gosu.button_down? Gosu::char_to_button_id('S')
      @y+=@speed
    end
  end
  
  def draw
    @image.draw_rot(@x, @y, 1, 0.0)
  end
  
  #-------------------------------------------------------------------
  # Get Functions
  #-------------------------------------------------------------------
  
  def getX
    return @x
  end

  def getY
    return @y
  end  
  
end        