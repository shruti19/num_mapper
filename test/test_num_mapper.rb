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

	end
end