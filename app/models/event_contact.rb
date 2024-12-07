class EventContact < ApplicationRecord
  belongs_to :event, inverse_of: :event_contacts
end
