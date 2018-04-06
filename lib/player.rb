#---------------------------------------------------------------------
# Player class
#---------------------------------------------------------------------

class Player < Chingu::GameObject
  trait :bounding_box
  traits :collision_detection
  attr_reader :bullet_emitter, :new_life, :r_pause, :e_pause, :vector
  attr_accessor :last_x, :last_y, :direction, :cr, :rooms, :life, :essence,
                :interactable, :keys, :items, :speed

  def setup
    @image = Gosu::Image.new("sprites/player/starfighter.bmp")
    self.factor = 1
    self.input = { [:holding_left, :holding_a] => :holding_left,
                   [:holding_right, :holding_d] => :holding_right,
                   [:holding_up, :holding_w] => :holding_up,
                   [:holding_down, :holding_s] => :holding_down,
                    :holding_mouse_left => :fire,
                    :holding_e => :interact,
                    :holding_r => :essence_to_life}
    @speed = 6
    @vector = Vector.new(@x, @y)
    @keys = 2
    @items = []
    @e_pause = false
    @cr = options[:cr]
    @new_life = 50
    @life = 7 # 3 hearts, 6 lives total
    @essence = 0
    @interactable = nil
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
    bullet_emitter.at_mouse($p_bullets, [x,y], 15.0, 4.0, Gosu.milliseconds/100)
  end

  def move(x,y)
    @x += x
    if wall_collision?
       @x = @last_x
    end
    @y += y
    if wall_collision?
       @y = @last_y
    end
  end

  # checks for wall collisions of the current room
  def wall_collision?
    cr.walls.each do |w|
      flag = true
      if self.bounding_box_collision?(w) and !gate_collision?(self)
        return true
      end
    end
    return false
  end

  # checks for gate collisions of the current room
  def gate_collision?(obj)
    cr.gates.each do |g|
      if obj.bounding_box_collision?(g)
        return true
      end
    end
    return false
  end

  # keeps track of which room the player is in
  def set_current_room
    if cr.defeated
      $map.level_rooms.each do |r|
        if self.bounding_box_collision?(r)
          @cr = r
        end
      end
      $map.hallways.each do |h|
        if self.bounding_box_collision?(h)
          @cr = h
        end
      end
    end
  end

  # checks for enemy bullet collisions
  # destroys bullet, life goes down by one
  # hud updated accordingly
  def enemy_bullet_collision
    if cr.defeated == false
      $e_bullets.delete_if do |b|
        if self.bounding_box_collision?(b)
          @life -= 1
          $hud.set_lives(life)
          b.destroy
          true
        end
      end
    end
  end

  # R button input
  # player can press R when they have
  # 50 essence to spend to gain a half heart
  def essence_to_life
    if not r_pause
      if essence >= new_life
        @essence -= new_life
        @life += 1
        $hud.set_lives(life)
        $sm.play_sound("regain1",1.0,1.0,false)
        @r_pause = true
      else
        $sm.play_sound("error",0.5,1.0,false)
        @r_pause = true
      end
    end
  end

  # player can interact with objects (chests, etc.)
  # and friendly NPCs when in range
  def interact
    if not e_pause
      if interactable.is_a?(Chest)
        if @keys > 0 and interactable.locked
          interactable.unlock
          @keys -= 1
          @e_pause = true
        end
      end
    end
  end

  def update
    set_current_room
    enemy_bullet_collision
    if !Gosu.button_down? Gosu::char_to_button_id('R')
      @r_pause = false
    end
    if !Gosu.button_down? Gosu::char_to_button_id('E')
      @e_pause = false
    end
    #puts cr.label
    @last_x, @last_y = @x, @y
    # player is always in the screen center (300,300)
    dx = $width/2 - $window.mouse_x
    dy = $height/2 - $window.mouse_y
    @angle = -Gosu.radians_to_degrees(Math.atan2(dx, dy))
    vector.set(x,y)
  end

end
