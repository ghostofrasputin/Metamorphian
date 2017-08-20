#---------------------------------------------------------------------
# Player class
#---------------------------------------------------------------------

class Player
  
  attr_reader :x, :y, :w, :h, :speed, :bullet_emitter
  
  def initialize(x, y)
    @image = Gosu::Image.new("sprites/starfighter.bmp")
    @x = x
    @y = y
    @w = @image.width
    @h = @image.height
    @speed = 3.0
    @angle = 0.0
    @bullet_emitter = BulletEmitter.new
  end    
  
  def update
    
    # fire bullet when O button is pressed
    #if Gosu.button_down? Gosu::char_to_button_id('O')
    #  bullet_emitter.line($bullets, [x,y], 10.0, -90, 2.0, Gosu.milliseconds/100)
    #end
    
    if Gosu.button_down? Gosu::MsLeft
      bullet_emitter.at_mouse($bullets, [x,y], 10.0, -90, 2.0, Gosu.milliseconds/100)
    end
    
    # movement
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