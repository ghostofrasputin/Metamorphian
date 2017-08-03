#---------------------------------------------------------------------
# Food class
#---------------------------------------------------------------------

class Food
  attr_reader :x, :y, :z, :w, :h
  
  def initialize(x,y)
    @image = Gosu::Image.new("graphics/food.png")
    @x = x
    @y = y
    @z =  ZOrder::FOOD
    @w = @image.width
    @h = @image.height
    @animation = animation
  end
  
  
  def update
  end
  
  def draw
    @image.draw(x, y, ZOrder::FOOD)
  end
  
end