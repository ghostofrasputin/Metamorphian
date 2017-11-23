#---------------------------------------------------------------------
# Priority Queue: Binary Heap Implementation
#
# Based on:
# http://www.brianstorti.com/implementing-a-priority-queue-in-ruby/
#---------------------------------------------------------------------

class HeapQ

  class Element
    include Comparable
    attr_accessor priority, data
    def initialize(priority, data)
      @priority, @data = priority, data
    end
    def <=>(other)
      @priority <=> other.priority
    end
  end

  private_constant :Element
  attr_accessor elements

  def initialize
    @heap = [nil]
  end

  def <<(element)
    @heap << element
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
    return if c_1 > @heap.length-1
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

end
