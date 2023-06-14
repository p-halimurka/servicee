class Room < ApplicationRecord
  belongs_to :first_subscriber, class_name: 'User', foreign_key: :first_subscriber_id
  belongs_to :second_subscriber, class_name: 'User', foreign_key: :second_subscriber_id
  has_many :messages
end
