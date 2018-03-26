#---------------------------------------------------------------------
# Gate class
#---------------------------------------------------------------------

class Gate < Chingu::GameObject

  attr_reader :fakeRoom, :lock
  attr_accessor :room

  def setup
    @room = options[:room]
    @lock = false
    @fakeRoom = Room.create(:x=>room.x, :y=>room.y,:width => room.width/1.5,
      :height => room.width/1.5, :alpha=>0.0,
      #:color=>Gosu::Color.argb(0xff_000000), :alpha => 255
      :image=>Image["sprites/rooms/floor1/room.png"], :fake=>true)
  end

  def update
    # if player is in room, lock gate behind player
    if $player.first_collision(fakeRoom)
      lock = true
    end
    if lock
      up
    end
    # if current room is cleared destroy gate
    if room.defeated
      down
      fakeRoom.destroy
      destroy
    end
  end

  def up
    @image = Image["sprites/gate.png"]
  end

  def down
    @image = nil
  end
end
