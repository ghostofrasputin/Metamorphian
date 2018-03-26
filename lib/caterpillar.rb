#---------------------------------------------------------------------
# Caterpillar class
#---------------------------------------------------------------------

class Caterpillar < Chingu::GameObject
  trait :bounding_box
  traits :collision_detection
  attr_reader :speed, :food
  attr_accessor :goal_food

  def setup
    @image = Gosu::Image.new("sprites/caterpillar/caterpillar.png")
    @food = options[:food]
    @speed = 1.0
    @distance = Float::INFINITY
    @goal_food = nil
    @food_count = 0.0
  end

  def update

    if @food_count == 4
      Cocoon.create(:x=>x,:y=>y,:zorder=>ZOrder::ENEMY)
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
      if self.bounding_box_collision?(goal_food)
        @food_count += 1
        goal_food.destroy
        food.delete(goal_food)
      end
    end
  end

end
