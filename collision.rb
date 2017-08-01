#---------------------------------------------------------------------
# Collision module
#---------------------------------------------------------------------

module Collision
    
    # collision detection for 2 rectangles
    def self.rect_collision(rect1, rect2)
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
      return (minX < maxX2 && maxX > minX2 && minY < maxY2 && maxY > minY2)
    end
    
end