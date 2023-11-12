class OutingsController < ApplicationController
  def show
    @outing = Outing.find(params[:id])
    @contestants = @outing.contestants
  end

  def destroy
    outing = Outing.find(params[:outing_id])
    contestant = Contestant.find(params[:id])
    outing.contestants.delete(contestant)
    redirect_to "/outings/#{outing.id}"
  end
end