#---------------------------------------------------------------------
# Priority Queue: Binary Heap Implementation
#
# Based on:
# http://www.brianstorti.com/implementing-a-priority-queue-in-ruby/
# My additions:
# private inner Element class
# << operator override function updated
# isEmpty? function
#---------------------------------------------------------------------

class HeapQ

  class Element
    include Comparable
    attr_accessor :data, :priority
    def initialize(data, priority)
      @data, @priority = data, priority
    end
    def <=>(other)
      @priority <=> other.priority
    end
  end

  private_constant :Element
  attr_accessor :heap

  def initialize
    @heap = [666]
  end

  def <<(element)
    @heap << Element.new(element[0],element[1])
    bubble_up(@heap.length-1)
  end

  def pop
    swap(1, @heap.length-1)
    max = @heap.pop
    bubble_down(1)
    return max
  end

  def bubble_up(i)
    p_i = i/2
    return if i <= 1
    return if @heap[p_i] >= @heap[i]
    swap(i, p_i)
    bubble_up(p_i)
  end

  def bubble_down(i)
    c_i = i*2
    return if c_i > @heap.length-1
    not_last = c_i < @heap.size-1
    left = @heap[c_i]
    right = @heap[c_i+1]
    c_i += 1 if not_last and right > left
    return if @heap[i] >= @heap[c_i]
    swap(i, c_i)
    bubble_down(c_i)
  end

  def swap(src, tar)
    @heap[src], @heap[tar] = @heap[tar], @heap[src]
  end

  def isEmpty?
    if @heap.length == 1
      return true
    else
      return false
    end
  end

end
