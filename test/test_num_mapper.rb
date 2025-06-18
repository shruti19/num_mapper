require 'minitest/autorun'
require_relative '../num_mapper.rb'

class TestNumMapper < Minitest::Test

	describe "NumMapper#add" do
		it "Should have an add method" do
			 assert_respond_to NumMapper, :add
		end
	end
end