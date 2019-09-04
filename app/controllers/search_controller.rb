require_relative "../services/vehicles"

class SearchController < ApplicationController
  rescue_from Vehicles::RetrieveVehicle::InvalidVin do
    flash[:error] = "The requested vin is invalid, please verify"
    render "new"
  end

  def new
  end

  def create
    @vehicle = Vehicles.retrieve_vehicle(search_params[:q])
    if @vehicle
      flash[:notice] = "Successfully cached vehicle..."
      redirect_to :vehicles
    else
      flash[:error] = "The requested vehicle doesn't exist"
      render "new"
    end
  end

  private

  def search_params
    params.permit(:q, :authenticity_token)
  end
end
