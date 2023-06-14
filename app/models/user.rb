class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :service_provider
  has_one :service_consumer
  has_one :employee
  has_many :rooms, foreign_key: :first_subscriber_id
  has_many :rooms, foreign_key: :second_subscriber_id
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
end
