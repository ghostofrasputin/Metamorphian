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
  end
  
  def update
    # fire bullet:
    if Gosu.button_down? Gosu::char_to_button_id('O')
      @bullets << Bullet.new(@player.getX,@player.getY)
    end
    @bullets.each{|x| x.update}
    @player.update
  end
  
  def draw
    @bullets.each{|x| x.draw} 
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
