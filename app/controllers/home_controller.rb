class HomeController < ApplicationController
  def index
    @buildings = OruloService.new.render
  end
end
