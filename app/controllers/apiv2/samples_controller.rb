class Apiv2::SamplesController < ApplicationController
  def index
    @domains = Domain.includes(strats: {psus: {ssus: :samples}}).where(query_params)
    @animal_id = animal_param
  end

  private
    def query_params
      params.permit(:id => [], :year => [], :region => [])
    end

    def animal_param
      params.permit(:animal_id => [])
    end
end
