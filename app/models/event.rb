class Event < ApplicationRecord
  has_many :event_contacts, inverse_of: :event

  accepts_nested_attributes_for :event_contacts, reject_if: :all_blank, allow_destroy: true

  # attr_accessor :event_contacts_attributes
end
