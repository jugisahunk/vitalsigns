require './lib/vitals_github.rb'

class WelcomeController < ApplicationController
  def index
    vgh = VitalsGithub.new
    @greeting = vgh.do_it()
    puts @greeting
  end
end
