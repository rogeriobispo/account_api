class Aport < ApplicationRecord
  belongs_to :transaction
  validate :code, :transaction, presence: true
end
