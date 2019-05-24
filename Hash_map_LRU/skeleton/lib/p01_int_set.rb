class MaxIntSet
  attr_reader :store, :max

  def initialize(max)
    @store = Array.new(max) {false}
    @max = max
  end

  def insert(num)
    raise "Out of bounds" if num < 0 || num > @max
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end

require 'byebug'

class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
  end

  def insert(num)
    # debugger
    bucket = num % @num_buckets
    @store[bucket] << num
  end

  def remove(num)
    idx = @store[num % @num_buckets].index(num)
    @store[num % @num_buckets].delete_at(idx)
  end

  def include?(num)
    @store[num % @num_buckets].include?(num)
  end

  private

  def [](num)
    @store[num]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(num)
    if @count == @num_buckets
      resize!
    end
    unless include?(num)
      bucket = num % @num_buckets
      @store[bucket] << num
      @count += 1
    end
  end

  def remove(num)
    if include?(num)
      idx = @store[num % @num_buckets].index(num)
      @store[num % @num_buckets].delete_at(idx)
      @count -= 1
    end
  end

  def include?(num)
    @store[num % @num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num]
  end

  def num_buckets
    @store.length
  end

  def resize!
    ext = Array.new(num_buckets) {Array.new}
    @store.concat(ext)
    @store.each do |bucket|
      bucket.each do |el|
        remove(el)
        insert(el)
      end
    end
  end
end
