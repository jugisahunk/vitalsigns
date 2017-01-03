class MathHelper
  def self.calculate_mean(numbers)
      return numbers.inject { |sum, el| sum + el }.to_f / numbers.size
  end

  def self.calculate_median(numbers)
    if numbers.size == 1 then
      return numbers[0]
    elsif numbers.size == 2 then
      return numbers.inject(:+) / 2
    elsif numbers.size % 2 == 0 then
      sorted = numbers.sort
      left_index = sorted.size/2 -1
      right_index = sorted.size/2
      return (sorted[left_index] + sorted[right_index]) / 2.0
    else
      return numbers.sort[(numbers.size - 1) / 2]
    end
  end

  def self.calculate_level1_mean(numbers)
    upper_set = []
    median = MathHelper.calculate_median(numbers)

    upper_set = numbers.select { |number| number > median }
    if upper_set.size > 0 then 
      MathHelper.calculate_mean(upper_set)
    end
  end

  def self.calculate_level2_mean(numbers)
    level1_mean = MathHelper.calculate_level1_mean(numbers)
 
    if level1_mean == nil then return end

    upper_set = numbers.select { |number| number > level1_mean }

    if upper_set.size > 0 then
      MathHelper.calculate_mean(upper_set)
    end
  end

  def self.calculate_level3_mean(numbers)
    level2_mean = MathHelper.calculate_level2_mean(numbers)

    if level2_mean == nil then return end

    upper_set = numbers.select { |number| number > level2_mean }

    if upper_set.size > 0 then
      MathHelper.calculate_mean(upper_set)
    end
  end
end
