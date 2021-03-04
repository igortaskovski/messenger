class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy 
  has_one_attached :cover_picture

  validates :title, :body, presence: true, length: {minimum: 5}
  validates_associated :comments

  attribute :remove_cover_picture, :boolean, default: false

  after_save :purge_cover_picture, if: :remove_cover_picture
  private def purge_cover_picture
    cover_picture.purge_later
  end
end
