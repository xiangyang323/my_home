class ActivityController < ApplicationController

  def show
    @activity = Activity.find_by(id: params[:id])
  end
end
