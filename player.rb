#---------------------------------------------------------------------
# Player class
#---------------------------------------------------------------------

class Player
  
  attr_reader :x, :y, :w, :h, :speed
  
  def initialize(x, y)
    @image = Gosu::Image.new("sprites/starfighter.bmp")
    @x = x
    @y = y
    @w = @image.width
    @h = @image.height
    @speed = 3.0
    @angle = 0.0
  end    
  
  def update
    if Gosu.button_down? Gosu::char_to_button_id('A') and x >= 0.0 
      @x -= speed
    end
    if Gosu.button_down? Gosu::char_to_button_id('D') and x <= $width
      @x += speed
    end
    if Gosu.button_down? Gosu::char_to_button_id('W') and y >= 0.0
      @y -= speed
    end
    if Gosu.button_down? Gosu::char_to_button_id('S') and y <= $height
      @y+= speed
    end
    @x = x % $width
  end
  
  def draw
    @image.draw_rot(x, y, ZOrder::PLAYER, 0.0)
  end
    
end        