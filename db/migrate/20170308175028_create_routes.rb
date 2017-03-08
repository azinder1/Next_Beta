class CreateRoutes < ActiveRecord::Migration[5.0]
  def change
    create_table :routes do |t|
      t.string "name"
      t.string "difficulty_rating"
      t.string "description"
      t.string "lat"
      t.string "lng"
      t.integer "user_id"
    end
    create_table :comments do |t|
      t.integer "rating"
      t.string "content"
      t.integer "user_id"
      t.integer "route_id"
    end
  end
end
