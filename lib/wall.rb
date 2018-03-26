#---------------------------------------------------------------------
# Wall class
#---------------------------------------------------------------------

class Wall < Chingu::GameObject
  trait :bounding_box
  traits :collision_detection

  def setup
    @image = Image["sprites/wall.png"]
    self.factor = 1
  end
end
