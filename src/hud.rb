#---------------------------------------------------------------------
# HUD class
#---------------------------------------------------------------------

class Hud < GameObject

  attr_reader :heart, :half_heart, :heart_y_offset, :lives, :heart_spacing,
              :heart_x_offset,
              :essence_num, :essence_x_offset, :essence_y_offset, :essence_num,
              :key_x_offset, :key_y_offset, :key_num, :k_font,
              :room, :map_x_offset, :map_y_offset, :room_spacing, :backdrop,
              :hall, :cr, :ch, :boss_room, :treasure_room

  def setup
    # heart stuff
    @heart = Gosu::Image.new("sprites/hud/heart.png")
    @half_heart = Gosu::Image.new("sprites/hud/half_heart.png")
    @lives = $player.life
    @heart_spacing = 30
    @heart_x_offset = $width/2
    @heart_y_offset = $height/2

    # essence stuff
    @essence = Gosu::Image.new("sprites/hud/essence.png")
    @essence_x_offset = $width/2
    @essence_y_offset = ($height/2)-50
    @essence_num = $player.essence
    @e_font = Gosu::Font.new(30)

    # key stuff
    @key = Gosu::Image.new("sprites/hud/key.png")
    @key_x_offset = $width/2 - 70
    @key_y_offset = ($height/2)-50
    @key_num = $player.keys
    @k_font = Gosu::Font.new(30)

    # mini-map stuff
    @room = Gosu::Image.new("sprites/hud/mini_room.png")
    @boss_room = Gosu::Image.new("sprites/hud/boss_room.png")
    @treasure_room = Gosu::Image.new("sprites/hud/treasure_room.png")
    @backdrop = Gosu::Image.new("sprites/hud/backdrop.png")
    @hall = Gosu::Image.new("sprites/hud/mini_hall.png")
    @ch = Gosu::Image.new("sprites/hud/current_hall.png")
    @cr = [ Gosu::Image.new("sprites/hud/current_room.png"),
            Gosu::Image.new("sprites/hud/boss_room_current.png") ]
    @map_x_offset = $width/2 - 100
    @map_y_offset = $height/2
    @room_spacing = 20
  end

  def draw
    show_lives
    show_keys
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
          if col == 'B'
            @cr[1].draw(x,y,ZOrder::UI)
          else
            @cr[0].draw(x,y,ZOrder::UI)
          end
          draw_halls([i,j,0],x,y)
        elsif col == 'R'
          @room.draw(x,y,ZOrder::UI)
          draw_halls([i,j,0],x,y)
        elsif col == 'S'
          @room.draw(x,y,ZOrder::UI)
          draw_halls([i,j,0],x,y)
        elsif col == 'B'
          @boss_room.draw(x,y,ZOrder::UI)
          draw_halls([i,j,0],x,y)
        elsif col == 'T'
          @treasure_room.draw(x,y,ZOrder::UI)
          draw_halls([i,j,0],x,y)
        else
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
      x = $player.x-@heart_x_offset
      y = $player.y-@heart_y_offset
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
    @e_font.draw($player.essence,
               $player.x-@essence_x_offset+30,
               $player.y-@essence_y_offset-2,
               ZOrder::UI)
  end

  def show_keys
    @key.draw($player.x-@key_x_offset,
                  $player.y-@key_y_offset,
                  ZOrder::UI)
    @k_font.draw($player.keys,
               $player.x-@key_x_offset+20,
               $player.y-@key_y_offset-2,
               ZOrder::UI)
  end

  def set_lives(life)
    @lives = $player.life
  end

  def set_essence(essence)
    @essence_num = essence
  end

end
