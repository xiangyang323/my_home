class ActivityController < ApplicationController

  def show
    @show_join_activity_flag = true
    @activity = Activity.find_by(id: params[:id])
  end
end
