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

    

	end
end