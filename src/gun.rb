#---------------------------------------------------------------------
# Gun class
#---------------------------------------------------------------------

class Gun < Chingu::GameObject
  
  attr_reader :name, :magazine_size, :total_ammo, :speed, :freq, 
              :bullet_emitter#, :bullet_type
  
  def setup
    @image = Gosu::Image.new("sprites/guns/test/empty.png")
    @name = options[:name]
    @magazine_size = options[:magazine_size] ||= 10
    @ammo_in_chamber = magazine_size
    @total_ammo = options[:total_ammo] ||= 30
    @speed = options[:speed] ||= 3
    @freq = options[:freq] ||= 10
    #@bullet_type = options[:bullet_type]
    @bullet_emitter = BulletEmitter.new
  end
  
  def update
    # rotate gun around player and point at mouse
    @x = $player.x
    @y = $player.y
    dx = $width/2 - $window.mouse_x
    dy = $height/2 - $window.mouse_y
    @angle = -Gosu.radians_to_degrees(Math.atan2(dx, dy))
  end
  
  def fire(x,y)
    bullet_emitter.at_mouse($p_bullets, [x,y], 15.0, 4.0, Gosu.milliseconds/100) 
    @total_ammo -= 1
    @ammo_in_chamber -= 1
  end
  
  def reload
    if @total_ammo > 0
      @ammo_in_chamber = magazine_size
    else
      # play some sfx here
    end
  end
  
  def on
    @image = Gosu::Image.new("sprites/guns/test/default.png")
  end
  
  def off
    @image = Gosu::Image.new("sprites/guns/test/empty.png")
  end
  
end

#---------------------------------------------------------------------
# Load All Gun classes here:
#---------------------------------------------------------------------
require_relative 'guns\ak47'


