class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]

  def index
    @feeds = Feed.all
  end

  def show
    @favorite = current_user.favorites.find_by(feed_id: @feed.id)
  end

  def new
    if params[:back]
    @feed = Feed.new(feed_params)
  else
    @feed = Feed.new
    end
  end


  def edit
  end

  def create
    @feed = Feed.new(feed_params)
    @feed = current_user.feeds.build(feed_params)
    respond_to do |format|
      if @feed.save
        format.html { redirect_to @feed, notice: 'Feed was successfully created.' }
        # ContactMailer.contact_mail(@feed).deliver#画像が保存される時にメールを送る機能
      else
        format.html { render :new }
      end
    end
  end

  def confirm
    @feed = Feed.new(feed_params)
    @feed.user_id = current_user.id
    render :new if @feed.invalid?
  end

  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: 'Feed was successfully destroyed.' }
    end
  end

  private
  def set_feed
    @feed = Feed.find(params[:id])
    if @feed.user_id == current_user.id
    else
      redirect_to feeds_path, notice: "ログインユーザーが違うので編集できません"
    end
  end

  def feed_params
    params.require(:feed).permit(:image, :image_cache, :name)
  end
end
