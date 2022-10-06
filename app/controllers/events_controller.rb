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
    image = Cloudinary::Uploader.upload(params[:image])
    image1 = Cloudinary::Uploader.upload(params[:image1])
    image2 = Cloudinary::Uploader.upload(params[:image2])
    image3 = Cloudinary::Uploader.upload(params[:image3])
    image4 = Cloudinary::Uploader.upload(params[:image4])
    image5 = Cloudinary::Uploader.upload(params[:image5])
    puts image5, image
    @user = User.find(params[:user_id])
    @event = Event.new(image: image['url'], image1: image1['url'], image2: image2['url'],
                       image3: image3['url'], image4: image4['url'], image5: image5['url'],
                       name: event_params[:name], description: event_params[:description], date: event_params[:date])

    @event.user_id = @user.id

    puts @event
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
    params.permit(:name, :image, :image1, :image2, :image3, :image4, :image5, :description, :date, :user_id)
  end
end
