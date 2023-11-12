class BachelorettesController < ApplicationController
  def show
    @bachelorette = Bachelorette.find(params[:id])
    @contestants = @bachelorette.contestants
    @hometowns = @bachelorette.hometowns
  end
end