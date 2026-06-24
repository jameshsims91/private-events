class Event < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  has_many :event_attendances, foreign_key: :attended_event_id
  has_many :attendees, through: :event_attendances, source: :attendee

  has_many :invitations, dependent: :destroy
  has_many :invited_users, through: :invitations, source: :user

  scope :upcoming, -> { where("date >= ? AND private = ?", Date.today, false).order(date: :asc) }
  scope :past, -> { where("date < ? AND private = ?", Date.today, false).order(date: :desc) }

  scope :all_upcoming, -> { where("date >= ?", Date.today).order(date: :asc) }
  scope :all_past, -> { where("date < ?", Date.today).order(date: :desc) }

  validates :title, :date, presence: true
end
