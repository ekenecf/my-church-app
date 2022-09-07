class MembersController < ApplicationController
  before_action :set_member_params, only: %i[show update destroy]

  def index
    @user = User.find(params[:user_id])
    @members = Member.includes(:users).where(user: @user.id).order(name: :asc)
  end

  def show; end

  def new
    @user = User.find(params[:user_id])
    @member = Member.new
    @groups = @user.groups.where(user_id: @user.id).order(:name)
  end

  def create
    params = member_params
    created_member = Member.new(name: params[:name], phone_number: params[:phone_number],
                                occupation: params[:occupation], picture: params[:picture],
                                distance: params[:distance], active: params[:active], post_held: params[:post_held],
                                birthday: params[:birthday])
    @user = User.find(params[:user_id])
    created_member.user = @user
    created_member.user_id = @user.id

    if created_member.save
      @group = Group.find(params[:group_id])
      created_member.groups << @group
      render json: created_member, status: :created
      flash[:notice] = 'member created successfully.'
      redirect_to user_members_path(@user, created_member)
    else
      render json: { errors: created_member.errors.full_messages },
             status: :unprocessible_entity
      @member = created_member
      render :new
    end
  end

  def update
    if @member.update(member_params)
      render json: @member, status: :updated
    else
      render json: { errors: @member.errors.full_messages },
             status: :unprocessible_entity
    end
  end

  def destroy
    @member.destroy
  end

  private

  def set_member_params
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:deal).permit(:name, :phone_number, :occupation, :picture, :distance, :active, :post_held,
                                 :birthday, :group_id)
  end
end
