class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true

  has_many :created_events, class_name: "Event", foreign_key: "creator_id", dependent: :destroy

  has_many :event_attendances, foreign_key: :attendee_id, dependent: :destroy
  has_many :attended_events, through: :event_attendances, source: :attended_event

  has_many :invitations, dependent: :destroy
  has_many :invited_events, through: :invitations, source: :event
end
