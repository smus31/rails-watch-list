class ListsController < ApplicationController
  before_action :set_list, only: %i[show edit update destroy]

  def index
    @lists = List.all
  end

  def show
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save # Will raise ActiveModel::ForbiddenAttributesError
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @list.update(list_params) # Will raise ActiveModel::ForbiddenAttributesError
    redirect_to list_path(@list)
  end

  def destroy
    @list.destroy
    # No need for app/views/lists/destroy.html.erb
    redirect_to lists_path, status: :see_other
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name)
  end
end
