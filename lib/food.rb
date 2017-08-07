#---------------------------------------------------------------------
# Food class
#---------------------------------------------------------------------

class Food
  attr_reader :x, :y, :z, :w, :h
  
  def initialize(x,y)
    @image = Gosu::Image.new("sprites/food.png")
    @x = x
    @y = y
    @z =  ZOrder::FOOD
    @w = @image.width
    @h = @image.height
  end
   
  def update
  end
  
  def draw
    @image.draw_rot(x, y, ZOrder::FOOD, 0.0)
  end
  
end