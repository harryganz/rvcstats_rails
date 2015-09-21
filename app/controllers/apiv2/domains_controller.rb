class Apiv2::DomainsController < ApplicationController
  def index
    @domains = Domain.where(query_params)
  end

  private
    def query_params
      params.permit(:id => [], :year => [], :region => [])
    end
end
