class StaticPagesController < ApplicationController
  def not_found
    redirect_to root_path
  end

  def index
    @events = Event.includes(:venue)
    @next_events = @events.order(:date).first(5)
    @just_added = @events.last(2)
  end
end
