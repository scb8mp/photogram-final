Rails.application.routes.draw do
  devise_for :users

  root "users#index"

  # Users
  get "/users", to: "users#index"
  get "/users/:username/feed", to: "users#feed", as: :user_feed
  get "/users/:username", to: "users#show", as: :user_profile

  # Likes
  post "/insert_like", to: "likes#create"
  get "/likes", to: "likes#index"
  get "/likes/:path_id", to: "likes#show"
  post "/modify_like/:path_id", to: "likes#update"
  get "/delete_like/:path_id", to: "likes#destroy"


  # FollowRequests
  post "/insert_followrequest", to: "followrequests#create"
  get "/followrequests", to: "followrequests#index"
  get "/followrequests/:path_id", to: "followrequests#show"
  post "/modify_followrequest/:path_id", to: "followrequests#update"
  get "/delete_followrequest/:path_id", to: "followrequests#destroy"

  # Comments
  post "/insert_comment", to: "comments#create"
  get "/comments", to: "comments#index"
  get "/comments/:path_id", to: "comments#show"
  post "/modify_comment/:path_id", to: "comments#update"
  get "/delete_comment/:path_id", to: "comments#destroy"

  # Photos
  post "/insert_photo", to: "photos#create"
  get "/photos", to: "photos#index"
  get "/photos/:path_id", to: "photos#show", as: :photo
  post "/modify_photo/:path_id", to: "photos#update"
  get "/delete_photo/:path_id", to: "photos#destroy"
 

end
