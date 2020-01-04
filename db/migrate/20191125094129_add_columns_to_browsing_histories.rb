class AddColumnsToBrowsingHistories < ActiveRecord::Migration[5.2]
  def change
    add_column :browsing_histories, :user_id, :integer
    add_column :browsing_histories, :post_image_id, :integer
  end
end
