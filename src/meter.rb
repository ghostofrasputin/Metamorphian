#---------------------------------------------------------------------
# Meter class
#   shows a meter indicating the enemy transform rate
#---------------------------------------------------------------------

class Meter < Chingu::GameObject
  trait :bounding_box
  traits :collision_detection

  attr_reader :offset, :rate, :transform

  def setup
    @rate = 0
    @width = 0
    @length = 100
    @height = 10
    @offset = 30
  end

  def change_width(dmg_amt)
    @width = @width - dmg_amt
    if @width <= 0
      @width = 0
    end
    if @width >= 100
      @width = 100
    end
  end

  def set_xy(x,y)
    @x = x
    @y = y
  end

  def set_rate(rate)
    @rate = rate
  end

  def check_transform
    if @width >= 100
      return true
    end
    return false
  end

  def update
    @width += @rate
  end

  def draw
    $window.fill_rect(Chingu::Rect.new(@x-@length/2, @y-(@height+offset), @width, @height), 0xff_0000ff, ZOrder::INFO)
    $window.draw_rect(Chingu::Rect.new(@x-@length/2, @y-(@height+offset), @length, @height), 0xff_000000, ZOrder::INFO)
  end

end
