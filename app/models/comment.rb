class Comment < ActiveRecord::Base
  validates :content, :presence => true
  validates :rating, :presence => true
end
