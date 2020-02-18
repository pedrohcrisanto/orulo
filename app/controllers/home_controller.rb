class HomeController < ApplicationController
  def index
    @data = OruloService.new.find
  end
end
