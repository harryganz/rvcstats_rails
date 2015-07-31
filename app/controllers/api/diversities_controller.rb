class Api::DiversitiesController < ApplicationController
  def index
    @ssu = Ssu.includes(psu: {strat: :domain}).with_year(query_params[:year]).
      with_region(query_params[:region]).with_strat(query_params[:strat])
  end
  private
    def query_params
      params.permit(:year => [], :region => [], :strat => [])
    end
end
