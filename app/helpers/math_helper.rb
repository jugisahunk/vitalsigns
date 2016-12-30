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
end
