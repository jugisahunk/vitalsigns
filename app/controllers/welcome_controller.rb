
class WelcomeController < ApplicationController
  def index
    pr_stats = PullRequestStat.new()
    @stats = pr_stats.get_pr_stats()
  end
end
