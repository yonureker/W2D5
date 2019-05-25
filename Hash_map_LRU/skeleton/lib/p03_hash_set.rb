require 'byebug'
class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(key)
    if @count == @num_buckets
      resize!
    end
    bucket = key.hash % @num_buckets
    @store[bucket] << key
    @count += 1
  end

  def include?(key)
    bucket = key.hash % @num_buckets
    @store[bucket].include?(key)
  end

  def remove(key)
    # debugger
    bucket = key.hash % @num_buckets
    if @store[bucket].include?(key)
      idx = @store[bucket].index(key)
      @store[bucket].delete_at(idx)
      @count -= 1
    end
  end

  private

  def [](num)
    @store[num]
    # optional but useful; return the bucket corresponding to `num`
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
