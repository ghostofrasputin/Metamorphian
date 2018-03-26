#---------------------------------------------------------------------
# Player class
#---------------------------------------------------------------------

class Player < Chingu::GameObject
  trait :bounding_box, :debug => false
  traits :timer, :collision_detection
  attr_reader :bullet_emitter
  attr_accessor :last_x, :last_y, :direction

  def setup

    @image = Image["sprites/player/starfighter.bmp"]
    self.factor = 1
    self.input = { [:holding_left, :holding_a] => :holding_left,
                   [:holding_right, :holding_d] => :holding_right,
                   [:holding_up, :holding_w] => :holding_up,
                   [:holding_down, :holding_s] => :holding_down,
                    :holding_mouse_left => :fire }
    @speed = 4
    @last_x, @last_y = @x, @y
    @bullet_emitter = BulletEmitter.new
  end

  def holding_left
    move(-@speed, 0)
  end

  def holding_right
    move(@speed, 0)
  end

  def holding_up
    move(0, -@speed)
  end

  def holding_down
    move(0, @speed)
  end

  def fire
    bullet_emitter.at_mouse($bullets, [x,y], 15.0, 2.0, Gosu.milliseconds/100)
  end

  def move(x,y)
    @x += x
    @x = @last_x  if self.parent.viewport.outside_game_area?(self) #|| self.first_collision(Wall)

    @y += y
    @y = @last_y  if self.parent.viewport.outside_game_area?(self) #|| self.first_collision(Wall)
  end

  def update
    @last_x, @last_y = @x, @y
    # player is always in the screen center (300,300)
    dx = $width/2 - $window.mouse_x
    dy = $height/2 - $window.mouse_y
    @angle = -Gosu.radians_to_degrees(Math.atan2(dx, dy))
  end

  def remap(s, a1, a2, b1, b2)
    return b1 + (s-a1)*(b2-b1)/(a2-a1);
  end

end
