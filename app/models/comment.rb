# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  article_id :bigint           not null
#  body       :string
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Comment < ApplicationRecord
  scope :not_pending, -> { where.not status: :pending }
  scope :approved, -> { where status: :approved }

  enum :status, {rejected: 0, approved: 1, pending: 2}, default: :pending

  before_update :prevent_update_unless_status_is_pending
  before_destroy :prevent_destroy_unless_status_is_pending
  
  belongs_to :user
  belongs_to :article

  private
  def was_pending?
    if self.status_changed?
      self.status.to_sym != :pending
    else
      self.status.to_sym == :pending
    end
  end

  def prevent_update_unless_status_is_pending
    unless was_pending?
      errors.add :base, 'Cannot update if it is approved or rejected'
      throw :abort
    end
  end

  def prevent_destroy_unless_status_is_pending
    unless was_pending?
      errors.add :base, 'Cannot destroy if it is approved or rejected'
      throw :abort
    end
  end
end
