# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  comments_count         :integer
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  likes_count            :integer
#  private                :boolean
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many  :comments, class_name: "Comment", foreign_key: "photo_id", dependent: :destroy
         has_many  :followrequests, class_name: "Followrequest", foreign_key: "recipient_id", dependent: :destroy
         has_many  :likes, class_name: "Like", foreign_key: "fan_id", dependent: :destroy
         has_many  :photos, class_name: "Photo", foreign_key: "owner_id", dependent: :destroy

         
has_many :sent_follow_requests, class_name: "FollowRequest", foreign_key: "sender_id"
has_many :followed_users, through: :sent_follow_requests, source: :recipient


has_many :received_follow_requests, class_name: "FollowRequest", foreign_key: "recipient_id"
has_many :followers, through: :received_follow_requests, source: :sender
has_many :own_photos, class_name: "Photo", foreign_key: "owner_id"

def following?(other_user)
  FollowRequest.exists?(
    sender_id: self.id,
    recipient_id: other_user.id,
    status: "accepted"
  )
end

end
