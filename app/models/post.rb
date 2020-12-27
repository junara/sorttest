# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_one :latest_comment
end
