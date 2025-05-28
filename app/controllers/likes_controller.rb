class LikesController < ApplicationController
  def index
    matching_likes = Like.all

    @list_of_likes = matching_likes.order({ :created_at => :desc })

    render({ :template => "likes/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_likes = Like.where({ :id => the_id })

    @the_like = matching_likes.at(0)

    render({ :template => "likes/show" })
  end

def create
  like = Like.new
  like.photo_id = params[:photo_id]
  like.fan_id = params[:fan_id]

  if like.valid?
    like.save
    redirect_to("/photos/#{like.photo_id}", notice: "Like created successfully.")
  else
    redirect_to("/photos/#{like.photo_id}", alert: like.errors.full_messages.to_sentence)
  end
end

  def update
    the_id = params.fetch("path_id")
    the_like = Like.where({ :id => the_id }).at(0)

    the_like.fan_id = params.fetch("query_fan_id")
    the_like.photo_id = params.fetch("query_photo_id")

    if the_like.valid?
      the_like.save
      redirect_to("/likes/#{the_like.id}", { :notice => "Like updated successfully."} )
    else
      redirect_to("/likes/#{the_like.id}", { :alert => the_like.errors.full_messages.to_sentence })
    end
  end

  def destroy
  like = Like.find(params.fetch("path_id"))
  like.destroy
  redirect_to("/photos/#{like.photo_id}", notice: "Like removed successfully.")
end

end
