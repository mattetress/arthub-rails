class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to @event
    else
      render 'events/new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])

    @event.destroy

    redirect_to events_path 
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :start_time, :end_time, :location, :accepting_applications, :image)
  end

end
