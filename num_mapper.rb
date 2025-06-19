class NumMapper

  def self.add str
    @str = str
    sum = 0
    return sum if @str.empty?
    get_all_declared_delimiters
    
    result = {is_valid: true, message: nil}
    run_validations result
    
    if !result[:is_valid]
      return result[:message]
    end

    nums = @str.scan(/\d+/).select{|n| n.to_i < 1000}
    nums.each do |s|
      sum += s.to_i
    end

    sum
  end

  ## Filters out single char or/and multichar delimiters declared in string prefix
  def self.get_all_declared_delimiters
    delim_scanner = DelimScanner.new @str
    delim = delim_scanner.lookup_delimiters
    @scd = delim.is_a?(String) && delim.to_s.length == 1 ? delim : ''
    @mcd ||= []    
    if delim.is_a?(Array)
      delim.each do |d|
        @scd += d if d.length == 1
        @mcd << d if d.length > 1
      end
    end
  end

  def self.run_validations result
    negitives = @str.scan(/-\d+/).map(&:to_i)
    raise "negatives not allowed (found #{negitives.join(', ')})" if !negitives.empty?

    ## Delimiters should not be placed adjacent to each other
    append_regex1 = @mcd.empty? ? '' : @mcd.map{|m| "|[#{m[0]}]{#{m.length+1},}"}.join
    invalid_delim_placement_regex = /([#{@scd}\n,]){2,}#{append_regex1}/

    if !@str.scan(invalid_delim_placement_regex).empty? 
      result[:is_valid] = false
      result[:message] = "Invalid Input"
      return
    end

    ## Unidentified delimiter found
    append_regex2 = @mcd.empty? ? '' : @mcd.map{ |m| "(#{m[0]}{#{m.length}})" }.join
    unidentified_delim_regex = /[^,\n#{@scd}0-9#{append_regex2}]/
    
    if !@str.scan(unidentified_delim_regex).empty? 
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
    regex = /\/\/(.)\n/
    scd = @input.scan(regex).flatten[0]
    @input.gsub!(regex, '')
    return scd
  end

  def mixed_char_delim_scan
    regex = /\[(.*?)\]/
    mcd = @input.scan(regex).flatten
    @input.gsub!("//[#{mcd.join('][')}]\n", '')
    return mcd
  end

  def lookup_delimiters
    delim = single_char_delim_scan
    delim = mixed_char_delim_scan if delim.nil?
    return delim
  end

  def sanitized_input
    @input
  end

end