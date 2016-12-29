require 'test/unit'
require './lib/vitals_github.rb'
require 'httparty'

class VitalsGithub_Test < Test::Unit::TestCase

  def test_avg_pr_life
    vgh = VitalsGithub.new
    
    expected_avg = 7

    response = [
      {merged_at:DateTime.new(2016,12,25).to_s, created_at: DateTime.new(2016,12,15).to_s},
      {merged_at:DateTime.new(2016,12,25).to_s, created_at: DateTime.new(2016,12,21).to_s}
    ] 

    actual_avg = vgh.get_avg_pr_life(response)

    assert(expected_avg == actual_avg, "Expected: #{expected_avg} to equal: #{actual_avg}")
  end

end
