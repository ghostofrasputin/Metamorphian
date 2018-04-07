#---------------------------------------------------------------------
# Item class
#   base class for all items
#   loads all items for the game at the bottom
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
        $player.items << self
        effect
        destroy
      end
    end
  end

  def effect
  end

end

require_relative 'items\passive\speed_boots'
