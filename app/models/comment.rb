class Comment < ActiveRecord::Base
  validates :content, :presence => true
  validates :rating, :presence => true
  belongs_to :user
  belongs_to :route

end
