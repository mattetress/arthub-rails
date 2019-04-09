module ApplicationHelper
  def display_errors(object)
    render "artworks/error_messages", :object => object if object.errors.any?
  end
end
