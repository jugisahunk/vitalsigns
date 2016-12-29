require 'httparty'

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

  def calculate_avg_pr_life(average_collection, page_num, finished)
    if finished then 
      puts finished
      return average_collection.inject { |sum, el| sum + el }.to_f / average_collection.size
    end

    closed = get_closed(page_num)
    #puts closed.headers["link"]
    closed.each do |record|
      begin
        puts ""
        created = DateTime.strptime(record["created_at"])
        merged = DateTime.strptime(record["merged_at"])
        puts "Created: #{created}"
        puts "Merged: #{merged}"
        puts "Difference in minutes:"
        mins = (merged - created).to_f * 60 * 24
        puts mins
        average_collection << mins
        puts ""
        if merged < DateTime.now - 30 then
            return calculate_avg_pr_life(average_collection, page_num, true)
        end
      rescue Exception => e
        puts "==========================="
        # TODO: get created to closed if we want to look at waste figures
        puts created
        puts merged
        puts e.inspect
        puts "==========================="
      end
    end
    return calculate_avg_pr_life(average_collection, page_num += 1, false)
  end
end

vgh = VitalsGithub.new
avg = vgh.calculate_avg_pr_life([],1,false)
puts "Average time in minutes:"
puts avg
