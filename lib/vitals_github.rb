require 'httparty'

class VitalsGithub
  include HTTParty

  def initialize()
    config = YAML.load(File.read('config/credentials.yml'))
    @auth = {username: config['username'], password: config['password']}
    @base_uri = 'https://api.github.com'
  end

  def get_closed()
    options = {basic_auth: @auth}
    get_path = @base_uri + "/repos/mdx-dev/platform-api/pulls?state=closed&sort=updated&direction=desc"
    HTTParty.get(get_path, options)
  end

  def get_avg_pr_life(response)

  end
end

vgh = VitalsGithub.new
closed = vgh.get_closed
puts closed.headers["link"]
average_collection = []
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
  rescue Exception => e
    puts "==========================="
    # TODO: get created to closed if we want to look at waste figures
    puts created
    puts merged
    puts e.inspect
    puts "==========================="
   end
 end

puts "Average time in minutes:"
puts average_collection.inject { |sum, el| sum + el }.to_f / average_collection.size
