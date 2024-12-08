class Invitation < ApplicationRecord
  belongs_to :user, optional: true, inverse_of: :invitations
  accepts_nested_attributes_for :user

  validates :rsvp_answer, inclusion: { in: %w[yes no],
    message: "must be yes or no" }, if: -> { user.present? }
  validates :rsvp_count, presence: true, if: -> { user.present? && rsvp_answer_yes? }

  before_save do
    self.rsvp_count = nil if self.rsvp_answer_no?
  end

  enum :rsvp_answer, { no_answer: 0, yes: 1, no: 2 }, prefix: true

  before_destroy :ensure_something, prepend: true do
    throw(:abort) if errors.present?
  end

  private

  def ensure_something
    errors.add(:base, "Cannot delete invitation that is linked") if user.present?
  end
end
