class SearchesController < ApplicationController
  def index
  	@search = Search.new
  	@searches = Search.all
  end

  def show
  	@search = params[:id]
  	binding.pry
  end

  def create
  	accepted = params[:search][:accepted]
  	denied = params[:search][:denied]
  	search = Search.create(search_params)
  	redirect_to root_path
  end

  def edit
  	binding.pry
  end

  def destroy
  	search_id = params[:id]
  	Search.find(search_id).destroy
  	redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search
      @search = Search.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:search).permit(:name, :accepted, :denied, :user_id)
    end
end















