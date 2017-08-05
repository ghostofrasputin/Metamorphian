#---------------------------------------------------------------------
# Butterfly Bullet class
#---------------------------------------------------------------------

class ButterflyBullet
  
  attr_reader :x, :y, :w, :y, :r, :theta, :stage1, :stage2, :speed
  
  def initialize(x,y)
    @image = Gosu::Image.new("sprites/bullet.png")
    @x = x
    @y = y
    @w = @image.width
    @h = @image.height
    @r = 0.0
    @theta = 0.0
    @speed = 1.0
    @stage1 = true
    @stage2 = false
  end
  
  def update
    if stage1
      spiral_out
    end
  end
  
  def draw
    @image.draw_rot(x, y, ZOrder::BULLETS, 0.0)
  end
  
  def spiral_out
    x_diff = (x - 290).abs
    y_diff = (y - 700).abs
    c_flag = 1
    s_flag = 1
    c = Math.cos(theta)
    s = Math.sin(theta)
    if c < 0
      c_flag = -1
    end
    if s < 0
      s_flag = -1
    end  
    @x += c_flag*(c) + (x_diff)*0.007
    @y += s_flag*(s) + (y_diff)*0.007
    @theta += 0.01
  end
  
end
