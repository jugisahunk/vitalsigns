class WelcomeController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'

  def index
    uri = URI.parse("https://api.github.com/repos/mdx-dev/platform-api/pulls")
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "token eb7ffc5f01ab1732a8c8278fb99c213e40a080f6"
    
    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    parsed = JSON.parse(response.body)

    pr_id_list = ""

    parsed.each do |pull_request|
      pr_id_list += "id: " + pull_request["id"]
    end
    
    @data = pr_id_list
  end
end
