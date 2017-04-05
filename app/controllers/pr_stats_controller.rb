class PrStatsController < ApplicationController
    def get_pr_stats 
        pr_stats = PullRequestStat.new(params[:repo_name])
        render :json => pr_stats.get_pr_stats()
    end

    def get_pr_lifetimes
        pr_lifetimes = PullRequestStat.new(params[:repo_name])
        render :json => pr_lifetimes.get_pr_lifetimes([],1,false)
    end
end
