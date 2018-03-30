#---------------------------------------------------------------------
# Enemy class
#---------------------------------------------------------------------

class Enemy < Chingu::GameObject
  trait :bounding_box
  traits :collision_detection, :timer
  attr_reader :speed, :label, :life, :bullet_emitter, :t_flag

  def setup
    @label = options[:label]
    @t_flag = true
    @bullet_emitter = BulletEmitter.new
  end

  def update
    if $player.cr.label == label
      $p_bullets.delete_if do |b|
        if self.bounding_box_collision?(b)
          b.destroy
          during(100) { @color.alpha = 100 }.then { @color.alpha = 255 }
          @life -= 1.0
          true
        end
      end
    end
  end

  def spawn_essence
    for i in 1..rand(1..3)
      Essence.create(:x => rand(x-10..x+10),
                     :y => rand(y-10..y+10),
                     :zorder => ZOrder::ESSENCE)
    end
  end

  def death(list)
    if life <= 0
      list.pop()
      spawn_essence
      destroy
    end
  end

  def transform(time, object, list1, list2)
    if t_flag
      after(time) {
        object.create(:x=>x,:y=>y,:zorder=>ZOrder::ENEMY,:label=>label)
        list1 << 1
        list2.pop()
        destroy
      }
      @t_flag = false
    end
  end

end
