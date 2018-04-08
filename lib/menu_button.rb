#---------------------------------------------------------------------
# Menu Button class
#   buttons for the main game menu and in-game menu
#---------------------------------------------------------------------

class MenuButton < Chingu::GameObject
  trait :bounding_box
  traits :collision_detection

  attr_reader :main, :hover

  def setup
    @main = options[:main]
    @hover = options[:hover]
    @image = main
    @zorder = ZOrder::BUTTON
  end

  def event?
    mx = $window.mouse_x
    my = $window.mouse_y
    rx = x - width/2
    ry = y - height/2
    if mx > rx and mx < (rx + width) and my > ry and my < (ry + height)
      @image = hover
      if Gosu.button_down? Gosu::MsLeft
        return true
      end
    else
      @image = main
    end
    return false
  end

end
