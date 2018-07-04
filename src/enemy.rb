#---------------------------------------------------------------------
# Enemy class
#---------------------------------------------------------------------

class Enemy < Chingu::GameObject
  trait :bounding_box
  traits :collision_detection, :timer
  attr_reader :speed, :life, :bullet_emitter, :t_flag, :rate, :pos, :vel,
              :acc, :force, :transformable, :meter

  def setup
    @pos = Vector.new(@x, @y)
    angle = rand(Math::PI*2);
    @vel = Vector.new(Math.cos(angle), Math.sin(angle));
    @acc = Vector.new(0,0)
    @force = 0.03
    @t_flag = false
    @rate = 0.0
    @transformable = true
    @meter = Meter.create
    @bullet_emitter = BulletEmitter.new
  end

  def update
    hit_by_bullet
    standard_move
    update_meter
  end

  # defines death behavior
  def death(list)
    if life <= 0
      list.pop()
      spawn_essence
      @meter.destroy
      destroy
    end
  end

  # spawn essence upon death
  def spawn_essence
    for i in 1..rand(1..3)
      Essence.create(:x => rand(x-10..x+10),
                     :y => rand(y-10..y+10),
                     :zorder => ZOrder::ESSENCE)
    end
  end

  # defines metamorphosis behavior
  def transform(time, object, list1, list2)
    if t_flag
      list1 << object.create(:x=>x,:y=>y,:zorder=>ZOrder::ENEMY)
      list2.pop()
      @meter.destroy
      destroy
    end
  end

  # enemies lost life depending on what bullet their hit with
  # they also change color to visually show they are hit
  def hit_by_bullet
    $p_bullets.delete_if do |b|
      if self.bounding_box_collision?(b)
        @meter.change_width(b.dmg)
        b.destroy
        during(100) { @color.alpha = 100 }.then { @color.alpha = 255 }
        @life -= 1.0
        true
      end
    end
  end

  def update_meter
    if @transformable == true
      @meter.set_rate(rate)
      @meter.set_xy(@x,@y)
      if @meter.check_transform == true
        @t_flag = true
      end
    end
  end

  # enemies go towards player while avoiding each other
  def standard_move
    pos.set(x,y)
    tar = move_towards_player
    sep = seperate_from_enemies
    sep.scalar(5.5, '*')
    tar.scalar(4.0, '*')
    apply_force(sep)
    apply_force(tar)
    if acc.x == 0 and acc.y == 0
       return
    else
      vel.add(acc)
      vel.limit(speed)
    end
    pos.add(vel)
    @x = pos.x
    @y = pos.y
    acc.scalar(0, '*')
  end

  def apply_force(force)
     acc.add(force)
  end

  def move_towards_player
    steer = Vector.new(0,0)
    seperation = Math.sqrt((@image.width/2)**2 + (@image.height/2)**2) + 100
    if Gosu.distance($player.x, $player.y, x, y) > seperation
      position = Vector.new(0,0)
      position.copy(pos)
      target = Vector.new($player.x, $player.y)
      target.sub(position)
      target.normalize()
      target.scalar(speed, '*')
      target.sub(vel)
      target.limit(force)
      return target
    end
    return steer
  end

  def seperate_from_enemies
    count = 0
    seperation = Math.sqrt((@image.width/2)**2 + (@image.height/2)**2) + 100
    steer = Vector.new(0,0)
    position = Vector.new(0,0)
    enemies = $player.cr.enemies
    enemies.each do |enemy_type|
      if enemy_type != []
        enemy_type.each do |enemy|
          dist = Gosu.distance(enemy.x, enemy.y, x, y)
          if dist > 0 and dist < seperation
            position.copy(pos)
            position.sub(enemy.pos)
            position.normalize()
            position.scalar(dist, '/')
            steer.add(position)
            count += 1
          end
        end
      end
    end
    if count > 0
      steer.scalar(count, '/')
    end
    if steer.magnitude() > 0
      steer.normalize()
      steer.scalar(speed, '*')
      steer.sub(vel)
      steer.limit(force)
    end
    return steer
  end

end
