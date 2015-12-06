class OccurrencesController < ApplicationController

  def new
    @thing = Thing.find params[:thing_id]
    @occurrence = @thing.occurrences.build

    if @occurrence.save
      redirect_to thing_path(@thing)
    end
  end

  private

  def occurrence_params
    params.require(:occurrence).permit(:thing_id)
  end
end
