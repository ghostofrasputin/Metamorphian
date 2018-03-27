#---------------------------------------------------------------------
# HUD class
#---------------------------------------------------------------------

class Hud < GameObject

  attr_reader :heart, :half_heart, :heart_offset, :lives, :heart_spacing,
              :essence_num, :essence_x_offset, :essence_y_offset, :essence_num

  def setup
    # heart stuff
    @heart = Gosu::Image.new("sprites/hud/heart.png")
    @half_heart = Gosu::Image.new("sprites/hud/half_heart.png")
    @lives = $player.life
    @heart_spacing = 30
    @heart_offset = 295

    # essence stuff
    @essence = Gosu::Image.new("sprites/hud/essence.png")
    @essence_x_offset = 295
    @essence_y_offset = 270
    @essence_num = $player.essence
    @e_font = Gosu::Font.new(30)

    # mini-map stuff
    # @room =
    # @hall
  end

  def draw
    show_lives
    show_essence
  end

  def show_mini_map
  end

  def show_lives
    if lives >= 0
      x = $player.x-@heart_offset
      y = $player.y-@heart_offset
      if lives.even?
        for i in 1..lives/2
          @heart.draw(x,y,ZOrder::UI)
          x += @heart_spacing
        end
      else
        for i in 1..(lives/2).floor
          @heart.draw(x,y,ZOrder::UI)
          x += @heart_spacing
        end
        @half_heart.draw(x,y,ZOrder::UI)
      end
    end
  end

  def show_essence
    @essence.draw($player.x-@essence_x_offset,
                  $player.y-@essence_y_offset,
                  ZOrder::UI)
    @e_font.draw(essence_num,
               $player.x-@essence_x_offset+30,
               $player.y-@essence_y_offset-2,
               ZOrder::UI)
  end

  def set_lives(life)
    @lives = $player.life
  end

  def set_essence(essence)
    @essence_num = essence
  end

end
