class PostImagesController < ApplicationController
  def top
    flash[:success] = 'Signed out successfully'
  end

  def about
  end


  def new
    @postimage = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    @post_image.save
    redirect_to post_images_path
    flash[:success] = 'Book was successfully updated.'
  end

  def index
    @post_image_new = PostImage.new
    @post_images = PostImage.page(params[:page]).reverse_order
    @user = current_user
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
    @user = User.find(@post_image.user_id)
    @post_images = PostImage.new
    new_history = @post_image.browsing_histories.new
    new_history.user_id = current_user.id

    # 同一記事の重複チェック・重複時は古い履歴を削除
    if current_user.browsing_histories.exists?(post_image_id: "#{params[:id]}")
      old_history = current_user.browsing_histories.find_by(post_image_id: "#{params[:id]}")
      old_history.destroy
    end

    new_history.save

    histories_stock_limit = 10
    histories = current_user.browsing_histories.all
    if histories.count > histories_stock_limit
      histories[0].destroy
    end

  end

  def edit
    @post_image = PostImage.find(params[:id])
  end

  def update
    post_image = PostImage.new
    @post_image = PostImage.find(params[:id])
    @post_image.user_id = current_user.id
    if @post_image.update(post_image_params)
      redirect_to post_image_path(@post_image)
    else
      render :index
    end
    flash[:success] = 'Book was successfully updated.'
  end

  def destroy
    post_image = PostImage.find(params[:id])
    post_image.destroy
    redirect_to post_images_path
  end


  private
  def post_image_params
    params.require(:post_image).permit(:book_name, :image, :opinion)
  end

end
