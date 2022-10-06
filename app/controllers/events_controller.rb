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
    third_image = Cloudinary::Uploader.upload(params[:image3])
    forth_image = Cloudinary::Uploader.upload(params[:image4])
    last_image = Cloudinary::Uploader.upload(params[:image5])

    @user = User.find(params[:user_id])
    @event = Event.new(image: image0['url'], image1: first_image['url'], image2: second_image['url'],
                       image3: third_image['url'], image4: forth_image['url'], image5: last_image['url'],
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
