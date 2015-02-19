class Api::ParametersController < ApplicationController
  def index
    @parameters = Parameter.with_species(query_params[:species])
  end

  private

  #Whitelist queriable parameters
  def query_params
    params.permit(:species => [])
  end
end
