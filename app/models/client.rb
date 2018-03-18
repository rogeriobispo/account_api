class Client < ApplicationRecord
  belongs_to :person, polymorphic: true
  validates :name, presence: true
  enum status: [:active, :deactivated]
end
