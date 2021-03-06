#--------------------------------------------------------------------#
# Program: Metamorphian                                              #
# Author: Jacob Preston                                              #
#                                                                    #
# Description: Bullet Hell Rogue-Like Game                           #
#--------------------------------------------------------------------#

require 'chingu'
include Gosu
include Chingu
require_relative 'src\animation'
require_relative 'src\sound_manager'
require_relative 'src\menu_button'
require_relative 'src\vector'
require_relative 'src\meter'
require_relative 'src\bullet_emitter'
require_relative 'src\gate'
require_relative 'src\wall'
require_relative 'src\hallway'
require_relative 'src\item'
require_relative 'src\chest'
require_relative 'src\player'
require_relative 'src\food'
require_relative 'src\essence'
require_relative 'src\spawner'
require_relative 'src\enemy'
require_relative 'src\caterpillar'
require_relative 'src\nymph'
require_relative 'src\cocoon'
require_relative 'src\butterfly'
require_relative 'src\dragonfly'
require_relative 'src\room'
require_relative 'src\map'
require_relative 'src\hud'

#---------------------------------------------------------------------
# ZOrder Module
#   specifies in which order objects are drawn
#---------------------------------------------------------------------
module ZOrder
  BACKGROUND = 0
  BUTTON =     1
  ROOM =       1
  FOOD =       2
  WALL =       3
  CHEST =      3
  ENEMY =      4
  GATE =       4
  ITEM =       4
  PLAYER =     5
  GUN =        6
  ESSENCE =    6
  BUTTERFLY =  6
  BULLETS =    7
  INFO =       8
  UI =         9
  MOUSE =      10
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
    $width = (Gosu.screen_width * 1.5).to_i
    $height = (Gosu.screen_height * 1.5).to_i
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
    self.viewport.game_area = [0, 0, 12000+$width+$width/2, 12000+$width]
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

  attr_reader :start, :quit, :logo

  def initialize(options = {})
    super
    self.input = {:escape => :exit}
    offset = 200
    @start = MenuButton.create(:x=>$width/2,
                               :y=>$height/2 + offset,
                               :main => Gosu::Image.new("sprites/buttons/p.png"),
                               :hover => Gosu::Image.new("sprites/buttons/ph.png"))
    @quit = MenuButton.create( :x=>$width/2,
                               :y=>$height/2 + offset + 80,
                               :main => Gosu::Image.new("sprites/buttons/q.png"),
                               :hover => Gosu::Image.new("sprites/buttons/qh.png"))
    # logo by Robert Won
    @logo = Gosu::Image.new("sprites/logo.png")
  end

  def update
    super
    if start.event?
      switch_game_state(Play.new)
    end
    if quit.event?
      exit
    end
  end

  def draw
    super
    fill(Gosu::Color.rgba(0, 0, 0, 255), ZOrder::BACKGROUND)
    logo.draw_rot($width/2, $height/2-40, ZOrder::UI,0)
  end

end

Metamorphian.new.show
