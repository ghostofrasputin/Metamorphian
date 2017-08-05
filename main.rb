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
require_relative 'animation'
require_relative 'bullet_hell'
require_relative 'player'
require_relative 'bullet'
require_relative 'food'
require_relative 'spawner'
require_relative 'caterpillar'
require_relative 'nymph'
require_relative 'cocoon'
require_relative 'butterfly'
require_relative 'dragonfly'

#---------------------------------------------------------------------
# Global variables and data structures
#---------------------------------------------------------------------
$width = 800
$height = 800
$food = []
$bullets = []
$caterpillars = []
$cocoons = []
$butterflies = []
$nymphs = []
$dragonflies = []
$player = Player.new(290, 700)

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
# Module
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
end  

#---------------------------------------------------------------------
# Main class 
#   all game logic and drawing is done within this class
#---------------------------------------------------------------------


class Main < Gosu::Window
  
  attr_reader :player, :spawner, :bullets, :food, :nymphs, 
              :caterpillars, :cocoons, :butterflies, :dragonflies
  
  def initialize
    super $width, $height #, :fullscreen => true
    self.caption = "Metamorphian"
    @bullet_pause = 0.0
    @spawner = Spawner.new
    
    # LOAD ANIMATIONS:
    #@star_anim = Animation.new("graphics/star.png", 25, 25)
    
    # generate food randomly for now
    for i in 0..100
      $food << Food.new(rand($width),rand(50..$height))
    end
  end
  
  def update
    
    frameCount = Gosu.milliseconds/100
    spawner.update
    $caterpillars.each{|c| c.alive ? c.update : $caterpillars.delete(c)}
    $cocoons.each{|c| c.alive ? c.update : $cocoons.delete(c)}
    $butterflies.each{|b| b.alive ? b.update : $butterflies.delete(b)}
    
    # fire bullet
    if Gosu.button_down? Gosu::char_to_button_id('O') and frameCount > @bullet_pause+1.0 
      $bullets << Bullet.new($player.x,$player.y, 10.0, -90)
      @bullet_pause = frameCount
    end
    
    $bullets.each{|b| b.update}
    $player.update
    
    # Collision Logic:
    
    # player bullets collision
    $bullets.each do |b|
      # clean up bullets that go off screen
      if b.y < 0
        $bullets.delete(b)
      end
      # collision with caterpillars
      $caterpillars.each do |c|
        if rect_collision([b.x,b.y,b.w,b.h],[c.x,c.y,c.w,c.h])
          $caterpillars.delete(c)
          $bullets.delete(b)
        end
      end
      # collision with nymphs
      # collision with cocoons
      $cocoons.each do |c|
        if rect_collision([b.x,b.y,b.w,b.h],[c.x,c.y,c.w,c.h])
          # cocoons take 5 hits to die
          c.hits += 1
          $bullets.delete(b)
        end
      end
      # collision with butterflys
      $butterflies.each do |bu|
        if rect_collision([b.x,b.y,b.w,b.h],[bu.x,bu.y,bu.w,bu.h])
          # cocoons take 5 hits to die
          bu.hits += 1
          $bullets.delete(b)
        end
      end  
      # collision with dragonflies
    end
    
    # cocoon bullets with player
    $cocoons.each do |c|
      c.bullets do |b|
        if rect_collision([b.x,b.y,b.w,b.h],[$player.x,$player.y,$player.w,$player.h])
          puts "player was shot"
        end
      end
    end
    
  end
  
  def draw
    $food.each{|f| f.draw}
    $caterpillars.each{|c| c.draw}
    $cocoons.each{|c| c.draw}
    $butterflies.each{|b| b.draw}
    $bullets.each{|b| b.draw} 
    $player.draw
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
  
  # allow cursor over game window
  def needs_cursor?
    true
  end
  
end

Main.new.show
