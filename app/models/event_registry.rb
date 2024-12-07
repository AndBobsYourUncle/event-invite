class EventRegistry < ApplicationRecord
  belongs_to :event, inverse_of: :event_registries
end
