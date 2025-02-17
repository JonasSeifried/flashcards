class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[show edit update destroy]

  def index
    @groups = current_user.groups
  end

  def show
    authorize @group
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      @group.users << current_user
      redirect_to @group
    else
      flash[:alert] = @group.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    authorize @group
    if @group.update(group_params)
      redirect_to @group
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @group
    @group.destroy
    redirect_to groups_path
  end

  private
    def set_group
      @group = Group.find(params[:id])
    end

    def group_params
      params.expect!(group: [ :name ])
    end
end
