#---------------------------------------------------------------------
# HUD class
#---------------------------------------------------------------------

class Hud < GameObject

  attr_reader :heart, :half_heart, :heart_offset, :lives, :heart_spacing,
              :essence_num, :essence_x_offset, :essence_y_offset, :essence_num,
              :room, :map_x_offset, :map_y_offset, :room_spacing, :backdrop,
              :hall, :cr, :ch

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
    @room = Gosu::Image.new("sprites/hud/mini_room.png")
    @cr = Gosu::Image.new("sprites/hud/current_room.png")
    @backdrop = Gosu::Image.new("sprites/hud/backdrop.png")
    @hall = Gosu::Image.new("sprites/hud/mini_hall.png")
    @ch = Gosu::Image.new("sprites/hud/current_hall.png")
    @map_x_offset = 200
    @map_y_offset = 295
    @room_spacing = 20
  end

  def draw
    show_lives
    show_essence
    show_mini_map
  end

  def show_mini_map
    x = temp = $player.x+@map_x_offset
    y = $player.y-@map_y_offset
    @backdrop.draw(x-5,y-5,ZOrder::UI)
    $map.map.each_with_index do |row, i|
      x = temp
      row.each_with_index do |col , j|
        if $player.cr.key == [i,j]
          @cr.draw(x,y,ZOrder::UI)
          draw_halls([i,j,0],x,y)
        elsif col == 'R'
          @room.draw(x,y,ZOrder::UI)
          draw_halls([i,j,0],x,y)
        elsif col == 'S'
          @room.draw(x,y,ZOrder::UI)
          draw_halls([i,j,0],x,y)
        elsif col == 'B'
          @room.draw(x,y,ZOrder::UI)
          draw_halls([i,j,0],x,y)
        elsif col == 'W'
          #print 'W'
        else
          #print '#'
        end
        x += @room_spacing
      end
      y += @room_spacing
    end
  end

  def draw_halls(room_key,x,y)
    x += (@room.width)/2
    y += (@room.height)/2
    $map.hallways.each do |h|
      if room_key == h.key
        if h.flag == "t"
          y -= 9.5
        elsif h.flag == "d"
          y += 10.5
        elsif h.flag == "r"
          x +=  10.5
        elsif h.flag == "l"
          x -= 9.5
        end
        if $player.cr.key == [room_key[0],room_key[1],0]
          @ch.draw_rot(x,y,ZOrder::UI,0)
          return
        else
          @hall.draw_rot(x,y,ZOrder::UI,0)
          return
        end
      end
    end

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
