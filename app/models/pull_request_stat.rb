require 'httparty'

class PullRequestStat
  include HTTParty

  def initialize()
    config = YAML.load(File.read('config/credentials.yml'))
    @auth = {username: config['username'], password: config['password']}
    @base_uri = 'https://api.github.com'
  end

  def get_closed(page_num)
    options = {basic_auth: @auth}
    get_path = @base_uri + "/repos/mdx-dev/platform-api/pulls?state=closed&direction=desc&page=#{page_num}"
    HTTParty.get(get_path, options)
  end  

  def log_pr_info(created, merged, mins)
    puts ""
    puts "Created: #{created}"
    puts "Merged: #{merged}"
    puts "Difference in minutes:"
    puts mins
    puts ""
  end  

  def get_pr_lifetimes(pr_lifetimes, page_num, finished)
    if finished then 
      return pr_lifetimes
    end

    closed = get_closed(page_num)
    closed.each do |record|
      begin
        created = DateTime.strptime(record["created_at"])
        merged = DateTime.strptime(record["merged_at"])
        mins = (merged - created).to_f * 60 * 24
        pr_lifetimes << mins

        #log_pr_info(created, merged, mins)

        if merged < DateTime.now - 30 then
            return get_pr_lifetimes(pr_lifetimes, page_num, true)
        end
      rescue Exception => e
        #puts "==========================="
        # TODO: get created to closed if we want to look at waste figures
        #puts created
        #puts merged
        #puts e.inspect
        #puts "==========================="
      end
    end
    return get_pr_lifetimes(pr_lifetimes, page_num += 1, false)
  end

  def get_pr_stats do
    vgh = VitalsGithub.new

    pr_lifetimes = vgh.get_pr_lifetimes([],1,false)

    puts "Average times in minutes:"
    puts "Mean: #{MathHelper.calculate_mean(pr_lifetimes)}"
    puts "Median: #{MathHelper.calculate_median(pr_lifetimes)}"
    puts "Lev1 mean: #{MathHelper.calculate_level1_mean(pr_lifetimes)}"
    puts "Lev2 mean: #{MathHelper.calculate_level2_mean(pr_lifetimes)}"
    puts "Lev3 mean: #{MathHelper.calculate_level3_mean(pr_lifetimes)}"
    puts "Sample std dev: #{MathHelper.calculate_sample_std_dev(pr_lifetimes)}"
  end

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

  def self.calculate_sample_std_dev(numbers)
    if(numbers.count == 1 and numbers[0] == 0) then
      return Float::NAN
    end

    mean = calculate_mean(numbers)

    x = 0

    numbers.each do |number|
        x = x + ((Float(number) - Float(mean)) ** 2)
    end

    sample_variance = x / (numbers.count - 1)
    sample_std_dev = Math.sqrt(sample_variance)

    sample_std_dev.round(5) 
  end  
end
