class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    return 1.hash if self.empty?

    (self[0..-2].sum * 2 + self[-1]).hash
  end
end

class String
  def hash
    sum = 0
    self.each_char.with_index do |char, idx|
      sum += (char.ord * idx)
    end
    sum.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sum = 0
    self.each do |key, value|
      k = (key.to_s.ord * 2)
      v = (value.ord / 2)
      sum += (k + v)
    end
    sum.hash
  end
end
