class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_one :service_provider
  has_one :service_consumer
  has_one :employee
  has_many :first_subscriber_rooms, class_name: 'Room', foreign_key: :first_subscriber_id
  has_many :second_subscriber_rooms, class_name: 'Room', foreign_key: :second_subscriber_id
  has_many :messages

  attr_accessor :user_type

  def service_provider?
    service_provider.present?
  end

  def service_consumer?
    service_consumer.present?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def any_unread_messages?
    unread_messages = []
    user_id = id
    rooms = Room.where('first_subscriber_id = :user_id OR second_subscriber_id = :user_id', user_id: user_id)
    rooms.each do |r|
      r.messages.each do |m|
        unread_messages << m if m.user_id != user_id && m.unread?
      end
    end
    unread_messages.any?
  end

  def rooms
    Room.where('first_subscriber_id = :user_id OR second_subscriber_id = :user_id', user_id: id)
  end

=begin   def rooms
    first_subscriber_rooms + second_subscriber_rooms
  end 
=end

  def unread_messages_number_in_room_with(interlocutor_id)
    rooms.where('first_subscriber_id = :user_id OR second_subscriber_id = :user_id', user_id: interlocutor_id).first
         .messages.unread
         .where(user_id: interlocutor_id).count
  end
end
