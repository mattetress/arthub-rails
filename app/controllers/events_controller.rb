class EventsController < ApplicationController
  before_action :find_event, except: [:index, :new, :create, :past_events]
  before_action :owner_required, only: [:edit, :destroy, :update]

  def index
    @events = Event.where("end_time > ?", Time.now).order('start_time asc')
  end

  def past_events
    @events = Event.where("end_time < ?", Time.now).order('end_time desc')
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
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event
    else
      render 'events/edit'
    end
  end

  def destroy
    @event.destroy

    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :start_time, :end_time, :location, :accepting_applications, :image)
  end

  def owner_required
    return head(:forbidden) unless @event.user == current_user
  end

  def find_event
    @event = Event.find(params[:id])
  end

end
