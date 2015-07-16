class EventsController < ApplicationController
  def index
    @events = Event.includes(:category, :venue)
    @items = Item.active.not_in_cart(session[:cart]).paginate(:page => params[:page], :per_page => 10)
    @category = Category.find_by(name: params[:category])
    if @category
      @events = @events.where(category: @category).paginate(:page => params[:page], :per_page => 10)
    else
      @events = @events.all.paginate(:page => params[:page], :per_page => 10)
    end
  end

  def show
    @event = Event.find_by(id: params[:id])
    @items = @event.items.includes(:user).active.not_in_cart(session[:cart]).paginate(:page => params[:page], :per_page => 10)
  end

  def random
    event = Event.find(rand(0..Event.count))
    redirect_to event
  end
end
