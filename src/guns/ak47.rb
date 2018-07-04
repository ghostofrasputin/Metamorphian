#---------------------------------------------------------------------
# AK-47 class
#---------------------------------------------------------------------

class AK47 < Gun
  
  def setup
    super
  end
  
  def update
    super
  end
  
  def fire
    super
  end
  
  def reload
  end
  
  def on
    @image = Gosu::Image.new("sprites/guns/test/ak.png")
  end
  
  def off
    @image = Gosu::Image.new("sprites/guns/test/empty.png")
  end
  
end 