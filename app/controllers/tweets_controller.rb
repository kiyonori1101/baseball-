class TweetsController < ApplicationController
  # Ensure user is logged in for certain actions (standard Devise/Auth setup)
  before_action :authenticate_user!, except: [:index, :show]

  def index
    # Using .blank? is a cleaner way to check for nil or empty strings in Rails
    if params[:search].blank?
      @tweets = Tweet.all
    else
      @tweets = Tweet.where("comment LIKE ?", "%#{params[:search]}%")
    end
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id

    # Handle the 'question' array conversion if it exists
    if params[:tweet][:question].present?
      @tweet.question = params[:tweet][:question].join("")
    end

    if @tweet.save
      flash[:notice] = "投稿（診断）が完了しました"
      redirect_to tweet_path(@tweet)
    else
      # Using 'render' instead of 'redirect' allows you to show validation errors
      render :new
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    
    # Apply the same question joining logic for updates
    if params[:tweet][:question].present?
      @tweet.question = params[:tweet][:question].join("")
    end

    if @tweet.update(tweet_params)
      flash[:notice] = "更新しました"
      redirect_to tweet_path(@tweet)
    else
      render :edit
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to tweets_path, notice: "削除しました"
  end

  private

  def tweet_params
    # Merged all permitted parameters from both versions
    # Note: question: [] allows the controller to receive an array
    params.require(:tweet).permit(:name, :price, :review, :comment, :image, question: [])
  end
end