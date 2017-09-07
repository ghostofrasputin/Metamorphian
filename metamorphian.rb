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

#---------------------------------------------------------------------
# Import libraries and classes
#---------------------------------------------------------------------
require 'gosu'
require_relative 'lib\animation'
require_relative 'lib\sound_manager'
require_relative 'lib\room'
require_relative 'lib\map'
require_relative 'lib\crosshairs'
require_relative 'lib\bullet_emitter'
require_relative 'lib\player'
require_relative 'lib\food'
require_relative 'lib\spawner'
require_relative 'lib\caterpillar'
require_relative 'lib\nymph'
require_relative 'lib\cocoon'
require_relative 'lib\butterfly'
require_relative 'lib\dragonfly'

#---------------------------------------------------------------------
# Global variables and data structures
#---------------------------------------------------------------------
$width = 800
$height = 800
$food = []
$bullets = []
$cocoon_bullets = []
$butterfly_bullets = []
$caterpillars = []
$cocoons = []
$butterflies = []
$nymphs = []
$nymph_bullets = []
$dragonflies = []
$dragonfly_bullets = []
$player = Player.new(290, 700)
$sm = SoundManager.new
$crosshairs = Crosshairs.new

#---------------------------------------------------------------------
# Collision Detection Functions
#---------------------------------------------------------------------
  
  # collision detection for 2 rectangles
  def rect_collision(rect1, rect2)
    # rect 1
    minX = rect1[0]
    maxX = rect1[0] + rect1[2]
    minY = rect1[1]
    maxY = rect1[1] + rect1[3]
    # rect 2
    minX2 = rect2[0]
    maxX2 = rect2[0] + rect2[2]
    minY2 = rect2[1]
    maxY2 = rect2[1] + rect2[3]
    # return the result
    minX < maxX2 && maxX > minX2 && minY < maxY2 && maxY > minY2
  end

#---------------------------------------------------------------------
# ZOrder Module
#   specifies in which order objects are drawn
#---------------------------------------------------------------------  
  
module ZOrder
  BACKGROUND = 0
  FOOD =       1
  PLAYER =     2
  ENEMY =      3
  BUTTERFLY =  4
  BULLETS =    5
  UI =         6
  MOUSE =      7
end  

#---------------------------------------------------------------------
# Main class 
#   all game logic and drawing is done within this class
#---------------------------------------------------------------------


class Metamorphian < Gosu::Window
  
  attr_reader :spawner
  
  def initialize
    super $width, $height #, :fullscreen => true
    self.caption = "Metamorphian"
    @spawner = Spawner.new
    #$sm.play_sound("everglades", 0.6, 1.5, true)
    #$sm.play_sound("synth_melody", 0.5, 1.0, true)
    # LOAD ANIMATIONS:
    
    # generate food randomly for now
    for i in 0..100
      $food << Food.new(rand($width),rand(50..$height))
    end
  end
  
  def update
    
    $player.update
    $crosshairs.update(mouse_x, mouse_y)
    spawner.update
    
    $caterpillars.delete_if do |c|
      if c.dead
        true
      else
        c.update
        false
      end
    end
    
    $cocoons.delete_if do |c|
      if c.dead
        true
      else
        c.update
        false
      end
    end
    
    $butterflies.delete_if do |b|
      if b.dead
        true
      else
        b.update
        false
      end
    end  
    
    $bullets.delete_if do |b|
      flag = false
      
      # collision with caterpillars
      $caterpillars.each do |c|
        if rect_collision([b.x,b.y,b.w,b.h],[c.x,c.y,c.w,c.h])
          c.dead = true
          flag = true
        end
      end
      # collision with nymphs
      $nymphs.each do |n|
      end
      # collision with cocoons
      $cocoons.each do |c|
        if rect_collision([b.x,b.y,b.w,b.h],[c.x,c.y,c.w,c.h])
          # cocoons take 5 hits to die
          c.hits += 1
          flag = true
        end
      end
      # collision with butterflys
      $butterflies.each do |bu|
        if rect_collision([b.x,b.y,b.w,b.h],[bu.x,bu.y,bu.w,bu.h])
          # cocoons take 5 hits to die
          bu.hits += 1
          flag = true
        end
      end  
      # collision with dragonflies
      $dragonflies.each do |d|
      end
      
      # clean up bullets that go off screen order
      # hit an enemy
      if b.out_of_bounds or flag
        true
      else  
        b.update
        false
      end
    end
    
    player_collision_info = [$player.x,$player.y,$player.w,$player.h]
    
    # cocoon bullets with player
    $cocoon_bullets.delete_if do |cb|
      if cb.out_of_bounds or rect_collision([cb.x,cb.y,cb.w,cb.h],player_collision_info)
        #puts "player was shot by cocoon"
        true
      else
        cb.update
        false
      end  
    end
    
    # butterfly bullets with player
    $butterfly_bullets.delete_if do |bb|
      if bb.out_of_bounds or rect_collision([bb.x,bb.y,bb.w,bb.h],player_collision_info)
        #puts "player was shot by butterfly"
        true
      else
        bb.update
        false
      end  
    end
    
    # nymph bullets with the player
    #$nymph_bullets.delete_if do |nb|
    #end
    
    # dragonfly bullets with player
    #$dragonfly_bullets.delete_if |db|
    #end
    
  end
  
  def draw
    $food.each{|f| f.draw}
    $caterpillars.each{|c| c.draw}
    $cocoons.each{|c| c.draw}
    $cocoon_bullets.each{|cb| cb.draw}
    $butterflies.each{|b| b.draw}
    $butterfly_bullets.each{|bb| bb.draw}
    #$nymphs.each{|n| n.draw}
    #$nymph_bullets{|nb| nb.draw}
    #$dragonflies.each{|d| d.draw}
    #$dragonfly_bullets.each{|db| db.draw}
    $bullets.each{|b| b.draw} 
    $player.draw(mouse_x, mouse_y)
    $crosshairs.draw
  end
  
  #-------------------------------------------------------------------
  # Game Window Functions
  #-------------------------------------------------------------------
  
  # escape quits game
  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end
  
  # cursor boolean
  def needs_cursor?
    false
  end
  
end

Metamorphian.new.show
