class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end


def show
  @user = User.find_by!(username: params[:username])
  
  @pending_follow_requests = FollowRequest.where(
    recipient_id: @user.id,
    status: "pending"
  ).includes(:sender)

  render template: "users/show"
end


def feed
  @user = User.find_by!(username: params[:username])

  accepted_followed_user_ids = FollowRequest
    .where(sender_id: @user.id, status: "accepted")
    .pluck(:recipient_id)

  @feed_photos = Photo.where(owner_id: accepted_followed_user_ids).order(created_at: :desc)

  render template: "users/feed"
end



end
