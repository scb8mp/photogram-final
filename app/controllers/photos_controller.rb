class PhotosController < ApplicationController
  before_action :authenticate_user!

  def index
     @photos = Photo.joins(:owner).where(users: { private: false }).order(created_at: :desc)

  # Assign this to @list_of_photos too, if your view is still using it
  @list_of_photos = @photos

  render({ :template => "photos/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @photo = Photo.find_by(id: the_id)

    if @photo.nil?
      redirect_to "/photos", alert: "Photo not found."
    else
      render template: "photos/show"
    end
  end

  def create
    the_photo = Photo.new
    the_photo.image = params[:query_image] || params.dig(:photo, :image)
    the_photo.caption = params[:query_caption] || params.dig(:photo, :caption)
    the_photo.owner_id = current_user.id

    if the_photo.save
      redirect_to "/photos", notice: "Photo created successfully."
    else
      redirect_to "/photos", alert: the_photo.errors.full_messages.to_sentence
    end
  end

  def update
  the_id = params.fetch("path_id")
  the_photo = Photo.find(the_id)

  the_photo.caption = params.fetch("query_caption")
  the_photo.image = params[:query_image] if params[:query_image].present?
  the_photo.comments_count = params.fetch("query_comments_count")
  the_photo.likes_count = params.fetch("query_likes_count")
  the_photo.owner_id = params.fetch("query_owner_id")

  if the_photo.valid?
    the_photo.save
    redirect_to("/photos/#{the_photo.id}", notice: "Photo updated successfully.")
  else
    redirect_to("/photos/#{the_photo.id}", alert: the_photo.errors.full_messages.to_sentence)
  end
end

  def destroy
    the_id = params.fetch("path_id")
    the_photo = Photo.find_by(id: the_id)

    if the_photo
      the_photo.destroy
      redirect_to "/photos", notice: "Photo deleted successfully."
    else
      redirect_to "/photos", alert: "Photo not found."
    end
  end
end
