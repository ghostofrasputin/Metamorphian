#---------------------------------------------------------------------
# Speed Boots class
#---------------------------------------------------------------------

class SpeedBoots < Item

  def setup
    super
    @name = "Speed Boots"
    @description = "Faster Than The Flash"
    @image = Gosu::Image.new("sprites/items/boots.png")
  end

  def update
    super
  end

  def effect
    super
    $player.speed += 2
  end

end
