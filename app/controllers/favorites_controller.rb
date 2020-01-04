class FavoritesController < ApplicationController
	def create
       @favorite = current_user.favorites.create(post_image_id: params[:post_image_id])
       @post_image = PostImage.find(params[:post_image_id])
       render :create
   end
   def destroy
       @favorite = Favorite.find_by(post_image_id: params[:post_image_id], user_id: current_user.id)
       @favorite.destroy
       @post_image = PostImage.find(params[:post_image_id])
       render :destroy
   end
end
