class EventsController < ApplicationController
  skip_before_action :authenticate_request
  before_action :set_event, only: %i[show update destroy]

  def index
    @events = Event.all
    render json: @events, status: :ok
  end

  def show
    render json: @event, status: :ok
  end

  def new
    @event = Event.new
  end

  def create
    @user = User.find(params[:user_id])
    @event = Event.new(event_params)
    @event.user_id = @user.id

    if @event.save
      render json: @event, status: :created
    else
      render json: { errors: @event.errors.full_messages },
             status: :unprocessible_entity
    end
  end

  def update
    if @event.update(event_params)
      render json: @event, status: :created
    else
      render json: { errors: @event.errors.full_messages },
             status: :unprocessible_entity
    end
  end

  def destroy
    @event.destroy
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.permit(:name, :image, :image1, :image2, :image3, :image4, :description, :date, :user_id)
  end
end
