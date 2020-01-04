class PostImage < ApplicationRecord

	belongs_to :user
	attachment :image
	has_many :post_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
    has_many :favorited_users, through: :favorites, source: :user
    has_many :browsing_histories, dependent: :destroy


	def PostImage.search(search, user_or_post, how_search)
        if how_search == "1"
            PostImage.where(['book_name LIKE ?', "%#{search}%"])
        elsif how_search == "2"
            PostImage.where(['book_name LIKE ?', "%#{search}"])
        elsif how_search == "3"
            PostImage.where(['book_name LIKE ?', "#{search}%"])
        elsif how_search == "4"
            PostImage.where(['book_name LIKE ?', "#{search}"])
        else
            PostImage.all
        end
    end


end
