class EventsController < ApplicationController
  skip_before_action :authenticate_request
  before_action :set_event, only: %i[show update destroy]

  def index
    @events = Event.all.order(created_at: :desc)
    render json: @events, status: :ok
  end

  def show
    render json: @event, status: :ok
  end

  def create
    image0 = Cloudinary::Uploader.upload(params[:image])
    first_image = Cloudinary::Uploader.upload(params[:image1])
    second_image = Cloudinary::Uploader.upload(params[:image2])

    @user = User.find(params[:user_id])
    @event = Event.new(image: image0['url'], image1: first_image['url'], image2: second_image['url'],
                       name: event_params[:name], description: event_params[:description], date: event_params[:date])
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
    @user = User.find(params[:user_id])
    @event.destroy if @user.id
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.permit(:name, :image, :image1, :image2, :description, :date, :user_id)
  end
end
