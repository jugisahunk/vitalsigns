require 'test_helper'

class PullRequestStatTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "that a mean of 1 through 3 returns 2" do
    mean = PullRequestStat.calculate_mean([1,2,3])
  
    assert_equal 2, mean, "They aren't equal homestar!"
  end

  test "that the mean of a single number is that number" do
    number_set = [3.5]
    expected_mean = 3.5
    
    actual_mean = PullRequestStat.calculate_mean(number_set)

    assert(expected_mean == actual_mean, "Expected #{expected_mean} but got #{actual_mean}")
  end

  test "that the mean of 1 to 100 is 50.5" do
    number_set = [*1..100]
    expected_mean = 50.5

    actual_mean = PullRequestStat.calculate_mean(number_set)

    assert(expected_mean == actual_mean, "Expected #{expected_mean} but got #{actual_mean}")
  end

  test "that the median of a single number is that number" do
    number_set = [1]
    expected_median = 1

    actual_median = PullRequestStat.calculate_median(number_set)

    assert(expected_median == actual_median, "Expected #{expected_median} but got #{actual_median}")
  end

  test "that median of 1 and 5.5 is 3.25" do
    number_set = [1,5.5]
    expected_median = 3.25

    actual_median = PullRequestStat.calculate_median(number_set)

    assert(expected_median == actual_median, "Expected #{expected_median} but got #{actual_median}")
  end

  test "that median of 1, 5.5 and 8 is 5.5" do
    number_set = [1,5.5,8]
    expected_median = 5.5

    actual_median = PullRequestStat.calculate_median(number_set)

    assert(expected_median == actual_median, "Expected #{expected_median} but got #{actual_median}")
  end

  test "that median of an unsorted list is found" do
    number_set = [1,8,5.5]
    expected_median = 5.5

    actual_median = PullRequestStat.calculate_median(number_set)

    assert(expected_median == actual_median, "Expected #{expected_median} but got #{actual_median}")
  end

  test "that median of 4 numbers is found" do
    number_set = [1,5,8,10]
    expected_median = 6.5

    actual_median = PullRequestStat.calculate_median(number_set)

    assert(expected_median == actual_median, "Expected #{expected_median} but got #{actual_median}")
  end

  test "that median of 4 unsorted numbers is found" do
    number_set = [8,10,5,1]
    expected_median = 6.5

    actual_median = PullRequestStat.calculate_median(number_set)

    assert(expected_median == actual_median, "Expected #{expected_median} but got #{actual_median}")
  end

  test "that median of 4 unsorted numbers with negatives is found" do
    number_set = [-1,5.5,-8,10]
    expected_median = 2.25

    actual_median = PullRequestStat.calculate_median(number_set)

    assert(expected_median == actual_median, "Expected #{expected_median} but got #{actual_median}")
  end

  test "that level1 of 6.6 is nil" do
    number_set = [6.6]
    expected_level1_mean = nil

    actual_level1_mean = PullRequestStat.calculate_level1_mean(number_set)

    assert(expected_level1_mean == actual_level1_mean, "Expected #{expected_level1_mean} but got #{actual_level1_mean}")
  end

  test "that level1 of [5,6.6,7,1,2,3,4] is 6.2" do
    number_set = [5,6.6,7,1,2,3,4]
    expected_level1_mean = 6.2

    actual_level1_mean = PullRequestStat.calculate_level1_mean(number_set)

    assert(expected_level1_mean == actual_level1_mean, "Expected #{expected_level1_mean} but got #{actual_level1_mean}")
  end

  test "that level2 mean of single number is nil" do
    number_set = [6.6]
    expected_level2_mean = nil

    actual_level2_mean = PullRequestStat.calculate_level2_mean(number_set)

    assert(expected_level2_mean == actual_level2_mean, "Expected #{expected_level2_mean} but got #{actual_level2_mean}")
  end

  test "that level2 mean of [1,7,8,9,10,11,2,3,4,5,6.6] is 10.5" do
    number_set = [1,7,8,9,10,11,2,3,4,5,6.6] #66.6
    expected_level2_mean = 10.5

    actual_level2_mean = PullRequestStat.calculate_level2_mean(number_set)

    assert(expected_level2_mean == actual_level2_mean, "Expected #{expected_level2_mean} but got #{actual_level2_mean}")
  end

  test "that level3 mean of single number is nil" do
    number_set = [6.6]
    expected_level3_mean = nil

    actual_level3_mean = PullRequestStat.calculate_level3_mean(number_set)

    assert(expected_level3_mean == actual_level3_mean, "Expected #{expected_level3_mean} but got #{actual_level3_mean}")
  end

  test "that level3 mean of [1,7,8,9,10,11,2,3,4,5,6.6,56,89] is 89" do
    number_set = [1,7,8,9,10,11,2,3,4,5,6.6,56,89] 
    expected_level3_mean = 89

    actual_level3_mean = PullRequestStat.calculate_level3_mean(number_set)

    assert(expected_level3_mean == actual_level3_mean, "Expected #{expected_level3_mean} but got #{actual_level3_mean}")
  end

  test "that sample std dev for zero is NaN" do
    number_set = [0]

    actual_variance = PullRequestStat.calculate_sample_std_dev(number_set)

    assert(actual_variance.nan?, "Expected NaN but got #{actual_variance}")
  end

  test "that sample std dev 1 to 100 is 29.01149" do
    number_set = [*1..100]
    expected_sample_std_dev = 29.01149

    actual_sample_std_dev = PullRequestStat.calculate_sample_std_dev(number_set)

    assert(expected_sample_std_dev == actual_sample_std_dev, "Expected #{expected_sample_std_dev} but got #{actual_sample_std_dev}")
  end
end
