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
# Global variables
#---------------------------------------------------------------------
$width = 600
$height = 800

#-------------------------------------------------------------------
# Collision Detection Functions
#-------------------------------------------------------------------
  
  # collision detection for 2 rectangles
  def rect_collision(rect1, rect2)
    # rect 1
    minX = rect1[0];
    maxX = rect1[0] + rect1[2];
    minY = rect1[1];
    maxY = rect1[1] + rect1[3];
    # rect 2
    minX2 = rect2[0];
    maxX2 = rect2[0] + rect2[2];
    minY2 = rect2[1];
    maxY2 = rect2[1] + rect2[3];
    # return the result
    minX < maxX2 && maxX > minX2 && minY < maxY2 && maxY > minY2
  end

#---------------------------------------------------------------------
# Import libraries and classes
#---------------------------------------------------------------------
require 'gosu'
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
# Main class 
#   all game logic and drawing is done here
#---------------------------------------------------------------------
class Main < Gosu::Window
  
  attr_reader :player, :spawner, :bullets, :food, :nymphs, 
              :caterpillars, :cocoons, :butterflies, :dragonflies
  
  def initialize
    super $width, $height #, :fullscreen => true
    self.caption = "Metamorphian"
    @player = Player.new(290, 700)
    @bullets = []
    @food = []
    @caterpillars = []
    @cocoons = []
    @butterflies = []
    @nymphs = []
    @dragonflies = []
    @bulletPause = 0.0
    @spawner = Spawner.new
    # generate food randomly for now
    for i in 0..100
      food << Food.new(rand($width),rand($height))
    end
  end
  
  def update
    
    frameCount = Gosu.milliseconds/100
    spawner.update(caterpillars, food, cocoons)
    caterpillars.each{|c| c.alive ? c.update : caterpillars.delete(c)}
    cocoons.each{|c| c.update}
    # fire bullet
    if Gosu.button_down? Gosu::char_to_button_id('O') and frameCount > @bulletPause+1.0 
      bullets << Bullet.new(player.x,player.y, 10.0, "north")
      @bulletPause = frameCount
    end
    bullets.each{|b| b.update}
    player.update
    
    # Collision Logic:
    
    # player bullets collision
    bullets.each do |b|
      # clean up bullets that go off screen
      if b.y < 0
        bullets.delete(b)
      end
      # collision with caterpillars
      caterpillars.each do |c|
        if rect_collision([b.x,b.y,b.w,b.h],[c.x,c.y,c.w,c.h])
          caterpillars.delete(c)
          bullets.delete(b)
        end
      end
      # collision with nymphs
      # collision with cocoons
      cocoons.each do |c|
        if rect_collision([b.x,b.y,b.w,b.h],[c.x,c.y,c.w,c.h])
          # cocoons absorb fire, staying intact while destroying the
          # bullet
          bullets.delete(b)
        end
      end
      # collision with butterflys
      # collision with dragonflies
    end
    
    # cocoon bullets with player
    cocoons.each do |c|
      c.bullets do |b|
        if rect_collision([b.x,b.y,b.w,b.h],[player.x,player.y,player.w,player.h])
          puts "player was shot"
        end
      end
    end
    
  end
  
  def draw
    food.each{|f| f.draw}
    caterpillars.each{|c| c.draw}
    cocoons.each{|c| c.draw}
    bullets.each{|b| b.draw} 
    player.draw
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
