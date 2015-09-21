class Apiv2::SamplesController < ApplicationController
  def index
    @samples = Sample.where(query_params)
  end

  private
    def query_params
      params.permit(:id => [], :animal_id => [], :ssu_id => [])
    end
end
