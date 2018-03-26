#---------------------------------------------------------------------
# Caterpillar class
#---------------------------------------------------------------------

class Caterpillar < Chingu::GameObject
  trait :bounding_box
  traits :timer, :collision_detection
  attr_reader :speed, :food

  def setup
    @image = Image["sprites/caterpillar/caterpillar.png"]
    @food = options[:food]
    @speed = 1
    @distance = Float::INFINITY
    @goal_food = nil
    @food_count = 0.0
  end

  def update

    if @food_count == 2
      #$cocoons << Cocoon.new(x,y)
      destroy
    end

    food.each do |f|
      fx = f.x
      fy = f.y
      temp_dist = ((fx-x)**2.0+(fy-y)**2.0)**(0.5)
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
      # if caterpillar.first_collision(FOOD)
      #   @food_count+=1
      # end
    end
  end

end
