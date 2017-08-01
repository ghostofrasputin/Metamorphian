#---------------------------------------------------------------------
# Caterpillar class
#---------------------------------------------------------------------

class Caterpillar
  
  attr_reader :x, :y, :food, :speed
  
  def initialize(x,y,food)
    @image = Gosu::Image.new("graphics/caterpillar.png")
    @x = rand(x..x+100)
    @y = rand(y..y+100)
    @speed = 0.5
    @food = food
    @distance = Float::INFINITY 
    @goal_food = nil
  end
  
  def update
    food.each do |f|
      fx = f.x
      fy = f.y
      temp_dist = Math.sqrt((fx-x)**2+(fy-y)**2)
      if temp_dist < @distance 
        @distance = temp_dist
        @goal_food = f  
      end
    end
    @distance = Float::INFINITY 
    
    # go towards food goal
    if @goal_food != nil
      if @goal_food.x > x
        @x += speed
      end
      if @goal_food.x < x
        @x -= speed
      end
      if @goal_food.y > y
        @y += speed
      end
      if @goal_food.y < y
        @y -= speed
      end
    end  
    
    # caterpillar food collision
    if Collision.rect_collision([x,y,@image.width,@image.height],[@goal_food.x,@goal_food.y,5,5])
      food.delete(@goal_food)
    end
    
  end
  
  def draw
    @image.draw_rot(x, y, 1.0, 0.0)
  end
  
  def transform
  end
  
end
