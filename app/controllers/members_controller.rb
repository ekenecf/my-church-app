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

  def new
    @user = User.find(params[:user_id])
    @member = Member.new
    @groups = @user.groups.where(user_id: @user.id).order(:name)
  end

  def create
    member_p = member_params
    @created_member = Member.new(name: member_p[:name], phone_number: member_p[:phone_number],
                                 occupation: member_p[:occupation], picture: member_p[:picture],
                                 distance: member_p[:distance], active: member_p[:active],
                                 post_held: member_p[:post_held], birthday: member_p[:birthday])
    @user = User.find(params[:user_id])
    @created_member.user = @user
    @created_member.user_id = @user.id

    if @created_member.save
      @group = Group.find(member_p[:group_id])
      @created_member.groups << @group
      render json: @created_member, status: :created
      flash[:notice] = 'member created successfully.'
      redirect_to user_members_path(@user, @created_member)
    else
      render json: { errors: @created_member.errors.full_messages },
             status: :unprocessible_entity
      @member = @created_member
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
    params.require(:member).permit(:name, :phone_number, :occupation, :picture, :distance, :active, :post_held,
                                 :birthday, :group_id)
  end
end
