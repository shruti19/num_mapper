class NumMapper

  def self.add str
    sum = 0
    return sum if str.empty?

    nums = str.scan(/\d+/)
    nums.each do |s|
      sum += s.to_i
    end

    sum
  end
end