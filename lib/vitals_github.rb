require 'httparty'
load './app/helpers/math_helper.rb'

class VitalsGithub
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
end

vgh = VitalsGithub.new
pr_lifetimes = vgh.get_pr_lifetimes([],1,false)
puts "Average times in minutes:"
puts "Mean: #{MathHelper.calculate_mean(pr_lifetimes)}"
puts "Median: #{MathHelper.calculate_median(pr_lifetimes)}"
