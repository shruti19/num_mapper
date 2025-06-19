class NumMapper

  def self.add str
    sum = 0
    return sum if str.empty?
    
    delim_scanner = DelimScanner.new str
    delim, str = delim_scanner.lookup_delimiters
    @scd = delim if delim.to_s.length == 1
    @mcd = delim if delim.to_s.length > 1
    
    result = {is_valid: true, message: nil}
    run_validations str, result
    
    if !result[:is_valid]
      return result[:message]
    end

    nums = str.scan(/\d+/).select{|n| n.to_i < 1000}
    nums.each do |s|
      sum += s.to_i
    end

    sum
  end

  def self.run_validations str, result
    negitives = str.scan(/-\d+/).map(&:to_i)
    raise "negatives not allowed (found #{negitives.join(', ')})" if !negitives.empty?

    ## Delimiters should not be placed adjacent to each other
    append_regex1 = @mcd.nil? ? '' : "|[#{@mcd[0]}]{#{@mcd.length+1},}"
    invalid_delim_placement_regex = /([#{@scd}\n,]){2,}#{append_regex1}/

    if !str.scan(invalid_delim_placement_regex).empty? 
      result[:is_valid] = false
      result[:message] = "Invalid Input"
      return
    end

    ## Unidentified delimiter found
    append_regex2 = @mcd.nil? ? '' : "(#{@mcd[0]}{#{@mcd.length}})"
    unidentified_delim_regex = /[^,\n#{@scd}0-9#{append_regex2}]/

    if !str.scan(unidentified_delim_regex).empty? 
      result[:is_valid] = false
      result[:message] = "Invalid Delimiter"
      return
    end

  end

end

class DelimScanner

  def initialize str
    @input = str
  end

  def single_char_delim_scan
    scb = @input.scan(/\/\/(.)\n/).flatten[0]
    sanitized_input = @input.gsub(/\/\/(.)\n/, '')
    return scb, sanitized_input
  end

  def multi_char_delim_scan
    regex = /\/\/\[(.*)\]\n/
    mcd = @input.scan(regex).flatten[0]
    sanitized_input = @input.gsub(regex, '')
    return mcd, sanitized_input
  end

  def lookup_delimiters
    delim, sanitized_input = single_char_delim_scan
    delim, sanitized_input = multi_char_delim_scan if delim.nil?
    return delim, sanitized_input
  end

end