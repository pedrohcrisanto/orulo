class HomeController < ApplicationController
  def index
    @data = OruloService.new.find
  end

  def show  
    @data = OruloService.new.find
  end
end
