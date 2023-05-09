class Gossip < ApplicationRecord
  belongs_to :user
  has_many :gossip_tags
  has_many :tags, through: :gossip_tags
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable

  validates :title, presence: true, uniqueness: true, length: { minimum: 3, maximum: 34 } #Je sais que c'est 14 mais c'est galère pour la seed
  validates :content, presence: true, uniqueness: true, length: { minimum: 10, maximum: 1000 }
end
