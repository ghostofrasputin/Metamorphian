#---------------------------------------------------------------------
# Food class
#---------------------------------------------------------------------

class Food < Chingu::GameObject
  trait :bounding_box
  traits :timer, :collision_detection
  def setup
    @image = Image["sprites/food.png"]
  end

  def update
    #if self.first_collision(CATERPILLAR)
    #  destroy
    #end
  end

end
