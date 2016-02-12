class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :sponsered_posts, dependent: :destroy
end
