Rails.application.routes.draw do
  get 'welcome/index'
  get 'pr_stats/get_pr_stats'
  get 'pr_stats/get_pr_lifetimes'

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
