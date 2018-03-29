#---------------------------------------------------------------------
# Chest class
#---------------------------------------------------------------------
class Chest < Chingu::GameObject
  trait :bounding_box
  traits :collision_detection
  attr_reader :type, :unlock_img, :locked, :label, :item

  def setup
    @label = options[:label]
    @image = Gosu::Image.new("sprites/chest/locked_chest.png")
    #@type = random_chest
    @locked = true
    @item = pick_item
  end

  def update
    if $player.cr.label == label
      if self.bounding_box_collision?($player) and locked
        $player.x = $player.last_x
        $player.y = $player.last_y
        $player.interactable = self
      end
    end
  end

  def unlock
    @locked = false
    $sm.play_sound("chest_open",1.0,1.0,false)
    @image = Gosu::Image.new("sprites/chest/unlocked_chest.png")
    $player.items << $item_table[item].create(:x=>x, :y=>y, :label=>label)
  end

  def pick_item
    return $item_table.keys.sample
  end


  # choose random chest
  # gold - rare items
  # silver - semi-rare items
  # bronze - common items
  def random_chest
    num = rand(1..30)
    if num >= 22
      #@image =
      #@unlock_img =
      return "gold"
    elsif num < 22 and num > 12
      #@image =
      #@unlock_img =
      return "silver"
    else
      #@image =
      #@unlock_img =
      return "bronze"
    end
  end

end
