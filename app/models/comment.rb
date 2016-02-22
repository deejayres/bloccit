class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  belongs_to :topic 

  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true
end
