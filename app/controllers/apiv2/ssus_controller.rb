class Apiv2::SsusController < ApplicationController
  def index
    @ssus = Ssu.where(query_params)
  end

  private
    def query_params
      params.permit(id: [], psu_id: [], station_nr: [])
    end
end
