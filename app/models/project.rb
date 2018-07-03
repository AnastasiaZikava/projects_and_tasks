class Project < ApplicationRecord
    has_many :tasks, dependent: :destroy

    validates :name, length: {minimum: 2}, presence: true
    validates :summary, length: {minimum: 10}, presence: true
    validates :end_date, :start_date, presence: true
    validate :validate_end_date_before_start_date

    private
    def validate_end_date_before_start_date
			if end_date && start_date
					errors.add(:end_date) if end_date < start_date
			end
    end
end
