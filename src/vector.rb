#---------------------------------------------------------------------
# Vector class
#---------------------------------------------------------------------

class Vector

  attr_reader :x, :y

  def initialize(x,y)
    @x = x
    @y = y
  end

  def set(x,y)
    @x = x
    @y = y
  end

  def copy(v)
    @x = v.x
    @y = v.y
  end

  def add(v)
    @x += v.x
    @y += v.y
  end

  def sub(v)
    @x -= v.x
    @y -= v.y
  end

  def mult(v)
    @x *= v.x
    @y *= v.y
  end

  def div(v)
    @x /= v.x
    @y /= v.y
  end

  def scalar(num, sign)
    if sign == '*'
      @x *= num
      @y *= num
    elsif sign == '/'
      @x /= num
      @y /= num
    end
  end

  def dist(v)
    return Gosu.distance(x,y,v.x,v.y)
  end

  def dot(v)
    return x*v.x + y*v.y
  end

  def magnitude
    return Math.sqrt(x*x + y*y)
  end

  def squared
    return x*x + y*y
  end

  def normalize
    m = magnitude
    @x /= m
    @y /= m
  end

  def limit(max)
    if squared > max*max
      normalize
      scalar(max, '*')
    end
  end

  def to_s
    puts("[ #{x}, #{y} ]")
  end

end
