class Ebook < ApplicationRecord
  validates :title, presence: true, length: { minimum: 1, maximum: 255 }
  validates :author, presence: true, length: { minimum: 1, maximum: 255 }
  validates :file_path, presence: true
  validates :file_size, presence: true, numericality: { only_integer: true, greater_than: 0 }
  
  scope :by_title, ->(title) { where("title ILIKE ?", "%#{title}%") }
  scope :by_author, ->(author) { where("author ILIKE ?", "%#{author}%") }
  scope :recent, -> { order(uploaded_at: :desc) }
end
