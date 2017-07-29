require 'gosu'

class MainGame < Gosu::Window
  def initialize
    super 640, 480   
    self.caption = "Metamorphian"
  end
  
  def update
    # ...
  end
  
  def draw
    # ...
  end
end

MainGame.new.show
