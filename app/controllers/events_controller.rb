class EventsController < ApplicationController
  before_action :find_event, except: [:index, :new, :create, :past_events]
  before_action :owner_required, only: [:edit, :destroy, :update]

  def index
    @events = Event.future_events
  end

  def past_events
    @events = Event.past_events
  end

  def new
    @event = Event.new
    @event.location = Location.new(event: @event)
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
    @comment = Comment.new
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

  def add_interest
    flash[:success] = "#{@event.name} has been added to your events."
    @event.users << current_user
    redirect_to @event
  end

  def remove_interest
    flash[:success] = "#{@event.name} successfully removed from your events."
    @event.users.delete(current_user)
    redirect_to @event
  end

  def users
  end 

  private

  def event_params
    params.require(:event).permit(:name, :description, :start_time, :end_time, :venue, :accepting_applications, :image, location_attributes: [:city_id, :area])
  end

  def owner_required
    return head(:forbidden) unless @event.user == current_user
  end

  def find_event
    @event = Event.find(params[:id])
  end

end
