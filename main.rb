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

#---------------------------------------------------------------------
# Import libraries and classes
#---------------------------------------------------------------------
require 'gosu'
require_relative 'collision'
require_relative 'player'
require_relative 'bullet'
require_relative 'food'
require_relative 'egg_cluster'
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
  
  attr_reader :player, :bullets, :food, :egg_clusters, :nymphs, 
              :caterpillars, :cocoons, :butterflies, :dragonflies
  
  def initialize
    super $width, $height #, :fullscreen => true
    self.caption = "Metamorphian"
    @player = Player.new(290, 700)
    @bullets = []
    @food = []
    
    # enemy life cycle
    @egg_clusters = []
    @caterpillars = []
    @cocoons = []
    @butterflies = []
    
    # ally life cycle
    @nymphs = []
    @dragonflies = []
    
    @bulletPause = 0.0
    egg_cluster = EggCluster.new(250,100)
    egg_clusters << egg_cluster
    
    # generate food randomly for now
    for i in 0..100
      food << Food.new(rand($width),rand($height))
    end
  end
  
  def update
    frameCount = Gosu.milliseconds/100
    
    egg_clusters.each{|e| e.update(caterpillars, food)}
    caterpillars.each{|c| c.update}
    
    # fire bullet
    if Gosu.button_down? Gosu::char_to_button_id('O') and frameCount > @bulletPause+1.0 
      bullets << Bullet.new(player.x,player.y)
      @bulletPause = frameCount
    end
    bullets.each{|b| b.update}
    
    # clean up bullets that go offscreen
    bullets.each do |b|
      if b.y < 0
        bullets.delete(b)
      end
    end
    
    player.update
  end
  
  def draw
    food.each{|f| f.draw}
    egg_clusters.each{|e| e.draw}
    caterpillars.each{|c| c.draw}
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
