class Api::BenthicController < ApplicationController
  def index
    @ssus = Ssu.with_year(query_params[:year]).
     with_region(query_params[:region]).with_strat(query_params[:strat])
  end

  private
    def query_params
      params.permit(:year => [], :region => [], :strat => [])
    end
end
