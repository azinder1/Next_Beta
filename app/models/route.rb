class Route < ActiveRecord::Base
  validates :name, :presence => true
  validates :difficulty_rating, :presence => true
  validates :description, :presence => true
  validates :lat, :presence => true
  validates :lng, :presence => true
  belongs_to :user
  has_many :comments

  def build_route()
    {
      type: "Feature",
      geometry: {
        type: "Point",
        coordinates: [self.lng.to_f, self.lat.to_f]
      },
      properties: {
        id: self.id,
        rating: self.difficulty_rating,
        title: self.name,
        :"marker-color" => "#FFFFFF",
        :"marker-symbol" => "circle",
        :"marker-size" => "medium",
      }
    }
  end
end
