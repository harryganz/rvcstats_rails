class Apiv2::PsusController < ApplicationController
  def index
    @psus = Psu.where(query_params)
  end

  private
    def query_params
      params.permit(id: [], primary_sample_unit: [], strat_id: [],
      subregion_nr: [], mpa_nr: [])
    end
end
