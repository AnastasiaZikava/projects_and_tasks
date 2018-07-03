class Task < ApplicationRecord
  belongs_to :project
  has_many :users

  validates :title, length: {minimum: 2}, presence: true
  validates :description, length: {minimum: 10}, presence: true
end
