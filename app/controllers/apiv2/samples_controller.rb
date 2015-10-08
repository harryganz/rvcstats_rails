class Apiv2::SamplesController < ApplicationController
  def index
    @domains = Domain.includes(strats: {psus: {ssus: :samples}}).
      where(query_params).
      with_animal_id(animal_params[:animal_id])
  end

  private
    def query_params
      params.permit(:id => [], :year => [], :region => [])
    end

    def animal_params
      params.permit(:animal_id => [])
    end
end
