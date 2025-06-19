require 'minitest/autorun'
require_relative '../num_mapper.rb'

class TestNumMapper < Minitest::Test

	describe "NumMapper#add" do
		it "Should have an add method" do
			 assert_respond_to NumMapper, :add
		end

		it "should return sum as 0 if string is empty" do
      assert_equal NumMapper.add(''), 0 
    end

    it "should return sum of integers present in comma separated string" do
      assert_equal NumMapper.add('1'), 1
      assert_equal NumMapper.add('1,2'), 3
      assert_equal NumMapper.add('0,3,2,4'), 9
    end

    it "should return sum of integers in a string delimited by comma or newline (\n)" do
      assert_equal NumMapper.add("1\n2"), 3
      assert_equal NumMapper.add("0,3\n2,4"), 9
    end

    it "should print 'Invalid Input' if comma and newline character are placed adjacent in a string" do
      assert_equal NumMapper.add("1\n3,4,2\n,3"), 'Invalid Input'
    end

    it "should throw execption if string has negative numbers and list all negative numbers" do
      err = assert_raises RuntimeError do 
        NumMapper.add("-1,2,-3,4")
      end
      assert_equal err.message, "negatives not allowed (found -1, -3)"
    end

    it "should print 'Invalid Input' if unidentified delimiter found" do
      assert_equal NumMapper.add("1\n3;4,2\n3"), 'Invalid Input'
    end

    it "should support adding new delimiter declared using string prefix '//[delimiter]\n'" do
      assert_equal NumMapper.add("//;\n1;2"), 3 
      assert_equal NumMapper.add("//|\n1|2,3\n4"), 10
    end

	end
end