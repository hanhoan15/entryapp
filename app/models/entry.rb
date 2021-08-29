class Entry < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_time_must_before_start_time, :start_time_cant_be_future, :time_overlapping

  private
  def end_time_must_before_start_time
    return unless time_changed?
    errors.add(:end_date, :before_start_time) if start_date > end_date
  end

  def time_changed?
    start_date_changed? || end_date_changed?
  end

  def start_time_cant_be_future
    errors.add(:base, :in_the_future) if start_date.to_date.beginning_of_day > Time.now.to_date.beginning_of_day
  end

  def time_overlapping
    errors.add(:base, :overlap) if Entry.where(start_date: start_date..end_date).
      or(Entry.where(end_date: start_date..end_date)).present?
  end
end
