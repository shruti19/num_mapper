class NumMapper
  attr_accessor :scd

  def self.add str
    sum = 0
    return sum if str.empty?
    
    @scd = str.scan(/\/\/(.)\n/).flatten[0]
    str.gsub!(/\/\/(.)\n/, '')

    result = {is_valid: true, message: nil}
    run_validations str, result
    
    if !result[:is_valid]
      return result[:message]
    end

    nums = str.scan(/\d+/)
    nums.each do |s|
      sum += s.to_i
    end

    sum
  end

  def self.run_validations str, result
    negitives = str.scan(/-\d+/).map(&:to_i)
    raise "negatives not allowed (found #{negitives.join(', ')})" if !negitives.empty?

    ## Delimiters should not be placed adjacent to each other
    if !str.scan(/([#{@scd}\n,]){2,}/).empty?
      result[:is_valid] = false
      result[:message] = "Invalid Input"
      return
    end

    ## Unidentified delimiter found
    if !str.scan(/[^,\n#{@scd}0-9]+/).empty?
      result[:is_valid] = false
      result[:message] = "Invalid Delimiter"
      return
    end

  end

end