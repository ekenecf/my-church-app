class GroupsController < ApplicationController
  skip_before_action :authenticate_request
  before_action :set_group, only: %i[show update destroy]

  def index
    @groups = Group.all
    render json: @groups, status: :ok
  end

  def show; end

  def create
    @group = Group.new(group_params)
    @user = User.find(params[:user_id])
    @group.user_id = @user.id

    if @group.save
      render json: @group, status: :created
    else
      render json: { errors: @group.errors.full_messages },
             status: :unprocessible_entity
    end
  end

  def update
    if @group.update(group_params)
      render json: @group, status: :updated
    else
      render json: { errors: @group.errors.full_messages },
             status: :unprocessible_entity
    end
  end

  def destroy
    @group.destroy
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.permit(:name, :detail, :user_id)
  end
end
