require 'test/unit'
require './lib/math_helper.rb'

class MathHelper_Test < Test::Unit::TestCase
  def test_mean_single_number
    number_set = [3.5]
    expected_mean = 3.5
    
    actual_mean = MathHelper.calculate_mean(number_set)

    assert(expected_mean == actual_mean, "Expected #{expected_mean} but got #{actual_mean}")
  end

  def test_mean_avg_two_numbers
    number_set = [3, 9.5]
    expected_mean = 6.25
    
    actual_mean = MathHelper.calculate_mean(number_set)

    assert(expected_mean == actual_mean, "Expected #{expected_mean} but got #{actual_mean}")
  end

  def test_median_single_number
    number_set = [1]
    expected_median = 1

    actual_median = MathHelper.calculate_median(number_set)

    assert(expected_median == actual_median, "Expected #{expected_median} but got #{actual_median}")
  end

  def test_median_two_numbers
    number_set = [1,5.5]
    expected_median = 3.25

    actual_median = MathHelper.calculate_median(number_set)

    assert(expected_median == actual_median, "Expected #{expected_median} but got #{actual_median}")
  end

  def test_median_three_numbers
    number_set = [1,5.5,8]
    expected_median = 5.5

    actual_median = MathHelper.calculate_median(number_set)

    assert(expected_median == actual_median, "Expected #{expected_median} but got #{actual_median}")
  end

  def test_median_three_numbers_unsorted
    number_set = [1,8,5.5]
    expected_median = 5.5

    actual_median = MathHelper.calculate_median(number_set)

    assert(expected_median == actual_median, "Expected #{expected_median} but got #{actual_median}")
  end

  def test_median_4_numbers
    number_set = [1,5,8,10]
    expected_median = 6.5

    actual_median = MathHelper.calculate_median(number_set)

    assert(expected_median == actual_median, "Expected #{expected_median} but got #{actual_median}")
  end

  def test_median_4_numbers_unordered
    number_set = [8,10,5,1]
    expected_median = 6.5

    actual_median = MathHelper.calculate_median(number_set)

    assert(expected_median == actual_median, "Expected #{expected_median} but got #{actual_median}")
  end

  def test_median_4_numbers_with_negatives_unsorted
    number_set = [-1,5.5,-8,10]
    expected_median = 2.25

    actual_median = MathHelper.calculate_median(number_set)

    assert(expected_median == actual_median, "Expected #{expected_median} but got #{actual_median}")
  end

  def test_level1_mean_single_number
    number_set = [6.6]
    expected_level1_mean = nil

    actual_level1_mean = MathHelper.calculate_level1_mean(number_set)

    assert(expected_level1_mean == actual_level1_mean, "Expected #{expected_level1_mean} but got #{actual_level1_mean}")
  end

  def test_level1_mean
    number_set = [5,6.6,7,1,2,3,4]
    expected_level1_mean = 6.2

    actual_level1_mean = MathHelper.calculate_level1_mean(number_set)

    assert(expected_level1_mean == actual_level1_mean, "Expected #{expected_level1_mean} but got #{actual_level1_mean}")
  end

  def test_level2_mean_single_number
    number_set = [6.6]
    expected_level2_mean = nil

    actual_level2_mean = MathHelper.calculate_level2_mean(number_set)

    assert(expected_level2_mean == actual_level2_mean, "Expected #{expected_level2_mean} but got #{actual_level2_mean}")
  end

  def test_level2_mean
    number_set = [1,7,8,9,10,11,2,3,4,5,6.6] #66.6
    expected_level2_mean = 10.5

    actual_level2_mean = MathHelper.calculate_level2_mean(number_set)

    assert(expected_level2_mean == actual_level2_mean, "Expected #{expected_level2_mean} but got #{actual_level2_mean}")
  end

  def test_level3_mean_single_number
    number_set = [6.6]
    expected_level3_mean = nil

    actual_level3_mean = MathHelper.calculate_level3_mean(number_set)

    assert(expected_level3_mean == actual_level3_mean, "Expected #{expected_level3_mean} but got #{actual_level3_mean}")
  end

  def test_level3_mean
    number_set = [1,7,8,9,10,11,2,3,4,5,6.6,56,89] 
    expected_level3_mean = 89

    actual_level3_mean = MathHelper.calculate_level3_mean(number_set)

    assert(expected_level3_mean == actual_level3_mean, "Expected #{expected_level3_mean} but got #{actual_level3_mean}")
  end

end
