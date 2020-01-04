class UsersController < ApplicationController
  def new
  end

  def index
  	@user = current_user
  	@users = User.page(params[:id]).reverse_order
  	@post_image = PostImage.new
  	@post_images = PostImage.all
  end

  def show
  	@post_image = PostImage.new
  	@user = User.find(params[:id])
  	@post_images = @user.post_images.page(params[:page]).reverse_order
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	@user.update(user_params)
  	redirect_to user_path(@user.id)
  	flash[:success] = 'success'
  	flash[:error] = 'error'
  end

  def following
      @user  = User.find(params[:id])
      @users = @user.followings
      render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  def search
    @user_or_post = params[:option]
    @how_search = params[:choice]
    if @user_or_post == "1"
      @users = User.search(params[:search], @user_or_post, @how_search)
    else
      @post_images = PostImage.search(params[:search], @user_or_post, @how_search)
    end
  end

  def browsing_histories
    @user = User.find_by(id: params[:id])
    @browsing_histories = BrowsingHistory.where(user_id: @user.id)
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
