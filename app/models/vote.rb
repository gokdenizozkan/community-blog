class Vote < ApplicationRecord
  enum status: {rejected: 0, approved: 1, pending: 2}, default: :pending

  belongs_to :user
  belongs_to :article
end
