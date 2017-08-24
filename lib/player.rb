#---------------------------------------------------------------------
# Player class
#---------------------------------------------------------------------

class Player
  
  attr_reader :x, :y, :w, :h, :speed, :bullet_emitter
  
  def initialize(x, y)
    @image = Gosu::Image.new("sprites/player/starfighter.bmp")
    @x = x
    @y = y
    @w = @image.width
    @h = @image.height
    @speed = 3.0
    @angle = 0.0
    @bullet_emitter = BulletEmitter.new
  end    
  
  def update
    
    # fires bullet in direction of mouse with mouse left click
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
  
  def draw(mx, my)
    delta_y = x - mx
    delta_x = y - my
    angle = -Gosu.radians_to_degrees(Math.atan2(delta_y, delta_x))
    @image.draw_rot(x, y, ZOrder::PLAYER, angle)
  end
    
end        