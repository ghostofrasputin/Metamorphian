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

require 'gosu'
require_relative 'player'
require_relative 'bullet'

class Main < Gosu::Window
  
  def initialize
    super 600, 800#, :fullscreen => true
    self.caption = "Metamorphian"
    @player = Player.new(200, 600)
    @bullets = []
    @bulletPause = 0.0
  end
  
  def update
    frameCount = Gosu.milliseconds/100
    # fire bullet:
    if Gosu.button_down? Gosu::char_to_button_id('O') and frameCount > @bulletPause+1 
      @bullets << Bullet.new(@player.x,@player.y)
      @bulletPause = frameCount
    end
    @bullets.each{|b| b.update}
    # clean up bullets that go offscreen:
    @bullets.each do |b|
      if b.y < 0
        @bullets.delete(b)
      end
    end
    
    @player.update
  end
  
  def draw
    @bullets.each{|b| b.draw} 
    @player.draw
  end
  
  #-------------------------------------------------------------------
  # Helper Functions
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
