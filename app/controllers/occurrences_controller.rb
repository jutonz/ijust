class OccurrencesController < ApplicationController

  def new
    @thing = Thing.find params[:thing_id]
    @occurrence = @thing.occurrences.build
  end

  def create
    @thing = Thing.find params[:thing_id]
    @occurrence = @thing.occurrences.build occurrence_params
    if @occurrence.save
      redirect_to thing_path(@thing)
    end
  end

  def destroy
    @occurrence = Occurrence.find params[:id]
    @thing = @occurrence.thing

    if @thing.occurrences.count == 1
      @thing.delete
      redirect_to root_url, message: "Thing deleted."
    else
      @occurrence.delete
      redirect_to thing_path(@thing)
    end
  end

  private

  def occurrence_params
    params.require(:occurrence).permit(:thing_id, :created_at)
  end
end
