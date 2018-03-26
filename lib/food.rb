#---------------------------------------------------------------------
# Food class
#---------------------------------------------------------------------

class Food < Chingu::GameObject
  trait :bounding_box
  traits :collision_detection
  def setup
    @image = Gosu::Image.new("sprites/food.png")
  end

end
