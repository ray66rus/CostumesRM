class CostumesController < ApplicationController
  def new
    @costume = Costume.new
  end
end
