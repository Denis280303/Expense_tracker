class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable
  has_many :expenses

  validates :login, presence: true, uniqueness: true
end
