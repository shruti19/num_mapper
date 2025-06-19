class NumMapper

  def self.add str
    sum = 0
    return sum if str.empty?
    
    run_validations str
    
    nums = str.scan(/\d+/)
    nums.each do |s|
      sum += s.to_i
    end

    sum
  end

  def self.run_validations str
    negitives = str.scan(/-\d+/).map(&:to_i)
    raise "negatives not allowed (found #{negitives.join(', ')})" if !negitives.empty?
  end

end