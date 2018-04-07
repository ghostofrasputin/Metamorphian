#--------------------------------------------------------------------#
# Program: Metamorphian                                              #
# Author: Jacob Preston                                              #
#                                                                    #
# Description: Bullet Hell Rogue-Like Game                           #
#--------------------------------------------------------------------#

require 'chingu'
include Gosu
include Chingu
require_relative 'lib\animation'
require_relative 'lib\sound_manager'
require_relative 'lib\vector'
require_relative 'lib\bullet_emitter'
require_relative 'lib\gate'
require_relative 'lib\wall'
require_relative 'lib\hallway'
require_relative 'lib\item'
require_relative 'lib\chest'
require_relative 'lib\player'
require_relative 'lib\food'
require_relative 'lib\essence'
require_relative 'lib\spawner'
require_relative 'lib\enemy'
require_relative 'lib\caterpillar'
require_relative 'lib\nymph'
require_relative 'lib\cocoon'
require_relative 'lib\butterfly'
require_relative 'lib\dragonfly'
require_relative 'lib\room'
require_relative 'lib\map'
require_relative 'lib\hud'

#---------------------------------------------------------------------
# ZOrder Module
#   specifies in which order objects are drawn
#---------------------------------------------------------------------
module ZOrder
  BACKGROUND = 0
  ROOM =       1
  FOOD =       2
  WALL =       3
  CHEST =      3
  ENEMY =      4
  GATE =       4
  ITEM =       4
  PLAYER =     5
  ESSENCE =    6
  BUTTERFLY =  6
  BULLETS =    7
  UI =         8
  MOUSE =      9
end

#---------------------------------------------------------------------
# Global variables and data structures
#---------------------------------------------------------------------
$width = nil
$height = nil
$player = nil
$map = nil
$hud = nil
$p_bullets = []
$e_bullets = []
$sm = SoundManager.new
$item_table = {"boots" => SpeedBoots }

#---------------------------------------------------------------------
# Game Window Setup
#---------------------------------------------------------------------
class Metamorphian < Chingu::Window
  def initialize()
    $width = (($window.send :screen_width ) * 1.5).to_i
    $height = (($window.send :screen_height) * 1.5).to_i
    super($width,$height,true)
    $window.caption = "Metamorphian"
    @cursor = false
    @cursor = Gosu::Image.new("sprites/crosshairs.png")
  end

  def setup
    #retrofy
    #self.factor = 3
    switch_game_state(Play.new)
  end

  def draw
    super
    @cursor.draw(self.mouse_x-10, self.mouse_y-10, 100)
  end

  def needs_cursor?
    false
  end

  def close
    close!
  end

end

#---------------------------------------------------------------------
# Play state
#---------------------------------------------------------------------
class Play < GameState

  trait :viewport
  attr_reader :spawner, :pause

  def initialize(options = {})
    super
    @pause = false
    self.input = { :escape => :exit, :holding_p => :pause}
    $sm.play_sound("everglades", 0.1, 1.5, true)
    self.viewport.lag = 0
    self.viewport.game_area = [0, 0, 6000+$width+$width/2, 6000+$width]
    $map = Map.new
    $map.generate_floor()
    $player = Player.create(:x => $map.starting_room.x,
                            :y => $map.starting_room.y,
                            :zorder => ZOrder::PLAYER,
                            :cr => $map.starting_room
    )
    $hud = Hud.create(:x => $player.x, :y => $player.y)
  end

  def update
    super
    self.viewport.center_around($player)
  end

  def pause
    if @pause
      game_objects.unpause!
      @pause = false
    else
      game_objects.pause!
      @pause = true
    end
  end

end

#---------------------------------------------------------------------
# Start Menu state
#---------------------------------------------------------------------
class StartMenu < GameState

  def initialize(options = {})
    super
    self.input = {:escape => :exit}
  end

  def update
    super
  end

  def draw
    super
  end

end

Metamorphian.new.show
