# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer
#  photo_id   :integer
#
class Comment < ApplicationRecord
belongs_to :photo, required: true, class_name: "User", foreign_key: "photo_id"
belongs_to :author, class_name: "User", foreign_key: "author_id"

end
