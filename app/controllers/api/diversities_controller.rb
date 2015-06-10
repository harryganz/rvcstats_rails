class Api::DiversitiesController < ApplicationController
  def index
    @diversities = Diversity.joins(:strat).where(strats: query_params)
  end

  #Whitelist query parameters
  def query_params
    params.permit(:year => [], :region => [], :strat => [])
  end
end
