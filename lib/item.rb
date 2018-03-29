#---------------------------------------------------------------------
# Item class
#---------------------------------------------------------------------

class Item < Chingu::GameObject
  trait :bounding_box
  traits :collision_detection

  attr_reader :label, :name, :description

  def setup
    @label = options[:label]
    @zorder = ZOrder::ITEM
  end

  def update
    if $player.cr.label == label
      if self.bounding_box_collision?($player)
        effect
        destroy
      end
    end
  end

  def effect
  end

end
