class MembersController < ApplicationController
  skip_before_action :authenticate_request
  before_action :set_member_params, only: %i[show update destroy]

  def index
    @members = Member.all
    render json: @members, status: :ok
  end

  def show
    render json: @member, status: :ok
  end

  def create
    image = Cloudinary::Uploader.upload(params[:picture])
    @user = User.find(params[:user_id])
    @group = Group.find(params[:group_id])
    @created_member = Member.new(picture: image['url'],  name: member_params[:name], phone_number: member_params[:phone_number],
    occupation: member_params[:occupation], distance: member_params[:distance],
    post_held: member_params[:post_held], birthday: member_params[:birthday])

    @created_member.user_id = @user.id
    @created_member.group_id = @group.id

    if @created_member.save
      render json: @created_member, status: :created
    else
      render json: { errors: @created_member.errors.full_messages },
             status: :unprocessible_entity
      @member = @created_member
      render :new
    end
  end

  def update
    if @member.update(name: member_params[:name], phone_number: member_params[:phone_number],
                      occupation: member_params[:occupation], picture: member_params[:picture],
                      distance: member_params[:distance],
                      post_held: member_params[:post_held], birthday: member_params[:birthday])
      render json: @member, status: :updated
    else
      render json: { errors: @member.errors.full_messages },
             status: :unprocessible_entity
    end
  end

  def destroy
    @member.destroy

    if @member.destroy
      render status: :ok
    end
  end

  private

  def set_member_params
    @member = Member.find(params[:id])
  end

  def member_params
    params.permit(:name, :phone_number, :occupation, :picture, :distance, :post_held,
                  :birthday, :user_id, :group_id)
  end
end
