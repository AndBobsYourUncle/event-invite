class Invitation < ApplicationRecord
  belongs_to :user, optional: true

  before_destroy :ensure_something, prepend: true do
    throw(:abort) if errors.present?
  end

  private

  def ensure_something
    errors.add(:base, "Cannot delete invitation that is linked") if user.present?
  end
end
