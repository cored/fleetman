require_relative "../services/vehicles"

class SearchController < ApplicationController
  def new
  end

  def create
    vehicle = Vehicles.retrieve_vehicle(search_params[:q])
    if vehicle
      flash[:notice] = "Successfully cached vehicle..."
      redirect_to :new
    else
      flash[:error] = "The requested vehicle doesn't exist"
      render :new
    end
  end

  private

  def search_params
    params.permit(:q)
  end
end
