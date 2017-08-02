#---------------------------------------------------------------------
# Caterpillar class
#---------------------------------------------------------------------

class Caterpillar
  
  attr_reader :x, :y, :w, :h, :food, :speed, :alive
  
  def initialize(x,y,food,cocoons)
    @image = Gosu::Image.new("graphics/caterpillar.png")
    @x = x
    @y = y
    @w = @image.width
    @h = @image.height
    @speed = 1
    @food = food
    @cocoons = cocoons
    @distance = Float::INFINITY 
    @goal_food = nil
    @food_count = 0.0
    @alive = true
  end
  
  def update
    
    if @food_count == 2
      @alive = false
      @cocoons << Cocoon.new(x,y)
    end
    
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
      
      # caterpillar food collision
      if rect_collision([x,y,w,h],[@goal_food.x,@goal_food.y,@goal_food.w,@goal_food.h])
        food.delete(@goal_food)
        @food_count+=1
      end
    end  
  
  end
  
  def draw
    @image.draw_rot(x, y, 1.0, 0.0)
  end
  
  def transform
  end
  
end
