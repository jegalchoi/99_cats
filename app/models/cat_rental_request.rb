class CatRentalRequest < ApplicationRecord
  STATUSES = [
    "PENDING",
    "APPROVED",
    "DENIED"
  ]

  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: STATUSES
  validate :overlapping_approved_requests

  belongs_to :cat

  def overlapping_requests
    cat_rental_request_id = self.id
    cat_id = self.cat_id
    start_date = self.start_date
    end_date  = self.end_date

    CatRentalRequest
      .select("*")
      .where('cat_rental_requests.id != ? 
        AND cat_id = ? 
        AND ((start_date >= ? OR start_date <= ?) OR (end_date >= ? OR end_date <= ?))', 
        cat_rental_request_id, cat_id, start_date, end_date, start_date, end_date)
  end

  def overlapping_approved_requests
    self.overlapping_requests
      .select("*")
      .where(status: 'APPROVED')
      .exists?
  end

  def overlapping_pending_requests
    self.overlapping_requests
      .select("*")
      .where(status: 'PENDING')
  end

  def pending?
    if self.status == 'PENDING'
      return true
    else
      return false
    end
  end

  def approve!
    ActiveRecord::Base.transaction do 
      self.status = "APPROVED"
      self.save

      self.overlapping_pending_requests.each do |overlapping_pending_request|
        overlapping_pending_request.status = "DENIED"
        overlapping_pending_request.save
      end
    end
  end

  def deny!
    ActiveRecord::Base.transaction do 
      self.status = "DENIED"
      self.save
    end
  end
end