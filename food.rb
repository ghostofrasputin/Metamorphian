#---------------------------------------------------------------------
# Food class
#---------------------------------------------------------------------

class Food
  attr_reader :x, :y, :w, :h
  
  def initialize(x,y)
    @image = Gosu::Image.new("graphics/food.png")
    @x = x
    @y = y
    @w = @image.width
    @h = @image.height
  end
  
  
  def update
  end
  
  def draw
    @image.draw(x, y, 1.0)
  end
  
end