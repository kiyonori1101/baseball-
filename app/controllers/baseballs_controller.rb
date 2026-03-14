class BaseballsController < ApplicationController
  def index
  end

  def new
    @baseball = Baseball.new
  end

  def show
    @baseball = Baseball.find(params[:id])
  end

  def create
    @baseball = Baseball.new(baseball_params)
    params[:baseball][:question] ? @baseball.question = params[:baseball][:question].join("") : false
    if @baseball.save
        flash[:notice] = "診断が完了しました"
        redirect_to baseball_path(@baseball.id)
    else
        redirect_to :action => "new"
    end
  end

private
  def baseball_params
      params.require(:baseball).permit(:id, question: [])
  end
end

