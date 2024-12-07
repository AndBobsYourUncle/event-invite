class Admin::EventsController < ApplicationController
  layout "admin"
  before_action :verify_admin
  before_action :get_event, only: %i[ edit update destroy ]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def update
    if @event.update!(event_params)
      redirect_to admin_events_path, notice: "Event updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to admin_events_path, notice: "Event created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @event.destroy
      redirect_to admin_events_path, notice: "Event deleted"
    else
      error_messages = @event.errors.full_messages.map { |e| e }.join(", ")

      redirect_to admin_events_path, alert: error_messages
    end
  end

  private

  def get_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.expect(event: [ :name, :event_time, :rsvp_by, :location, :city, :state, :zip ])
  end

  def verify_admin
    redirect_to root_path unless Current.user.admin?
  end
end
