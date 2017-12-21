require "administrate/base_dashboard"

class RouteDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    comments: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    difficulty_rating: Field::String,
    description: Field::String,
    lat: Field::String,
    lng: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :user,
    :comments,
    :id,
    :name,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :user,
    :comments,
    :id,
    :name,
    :difficulty_rating,
    :description,
    :lat,
    :lng,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user,
    :comments,
    :name,
    :difficulty_rating,
    :description,
    :lat,
    :lng,
  ].freeze

  # Overwrite this method to customize how routes are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(route)
  #   "Route ##{route.id}"
  # end
end
