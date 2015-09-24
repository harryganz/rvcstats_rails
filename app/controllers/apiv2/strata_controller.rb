class Apiv2::StrataController < ApplicationController
  def index
    @strata = Strat.where(query_params)
  end

  private
    def query_params
      params.permit(:id => [], :strat => [], :prot => [], :domain_id => [])
    end
end
