#--------------------------------------------------------------------#
# Program: Metamorphian                                              #
# Author: Jacob Preston                                              #
#                                                                    #
# Description: Arcade style fixed-shooter                            #
#                                                                    #
# Instructions:                                                      #
# move back and forth with A and D                                   #
# shoot by pressing the O button                                     #
# change bullets with the P button (if possible)                     #
#                                                                    #
#--------------------------------------------------------------------#

require 'chingu'
include Gosu
include Chingu
require_relative 'lib\animation'
require_relative 'lib\sound_manager'
require_relative 'lib\bullet_emitter'
require_relative 'lib\gate'
require_relative 'lib\wall'
require_relative 'lib\hallway'
require_relative 'lib\player'
require_relative 'lib\food'
require_relative 'lib\spawner'
require_relative 'lib\caterpillar'
require_relative 'lib\nymph'
require_relative 'lib\cocoon'
require_relative 'lib\butterfly'
require_relative 'lib\dragonfly'
require_relative 'lib\room'
require_relative 'lib\map'

#---------------------------------------------------------------------
# ZOrder Module
#   specifies in which order objects are drawn
#---------------------------------------------------------------------
module ZOrder
  BACKGROUND = 0
  ROOM =       1
  FOOD =       2
  WALL =       3
  ENEMY =      4
  GATE =       4
  PLAYER =     5
  BUTTERFLY =  6
  BULLETS =    7
  UI =         8
  MOUSE =      9
end

#---------------------------------------------------------------------
# Global variables and data structures
#---------------------------------------------------------------------
$width = 600
$height = 600
$p_bullets = []
$e_bullets = []
$player = nil
$map = nil
$sm = SoundManager.new

#---------------------------------------------------------------------
# Game Window Setup
#---------------------------------------------------------------------
class Metamorphian < Chingu::Window
  def initialize()
    super($width,$height,false)
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

end

#---------------------------------------------------------------------
# Play state
#---------------------------------------------------------------------
class Play < GameState

  trait :viewport
  attr_reader :spawner

  def initialize(options = {})
    super
    self.input = { :escape => :exit }
    $sm.play_sound("everglades", 0.6, 1.5, true)
    $sm.play_sound("synth_melody", 0.5, 1.0, true)
    self.viewport.lag = 0
    self.viewport.game_area = [0, 0, 6200, 6200]
    $map = Map.new
    $map.generate_floor()
    $player = Player.create(:x => $map.starting_room.x,
                            :y => $map.starting_room.y,
                            :zorder => ZOrder::PLAYER,
                            :cr => $map.starting_room
    )
  end

  def update
    super
    self.viewport.center_around($player)
  end

end

Metamorphian.new.show
