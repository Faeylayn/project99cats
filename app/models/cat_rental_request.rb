class CatRentalRequest < ActiveRecord::Base
  STATUS = ['pending', 'approved', 'denied']

  validates :cat_id, :start_date, :end_date, :status, :user_id, presence: true
  validates :status, :inclusion => STATUS
  validate :approved_overlapping_requests


  belongs_to(:cat,
      :class_name => "Cat",
      :foreign_key => :cat_id,
      :primary_key => :id,
      :dependent => :destroy
      )

   belongs_to(:user,
      :class_name => "User",
      :foreign_key => :user_id,
      :primary_key => :id

  )

  def overlapping_requests
    overlap = []

    requests = self.cat.requests
    requests.each do |request|
      if request.start_date < self.start_date && self.start_date < request.end_date
        overlap << request
      elsif request.start_date < self.end_date && self.end_date < request.end_date
        overlap << request
      elsif request.start_date > self.start_date && self.end_date > request.end_date
        overlap << request
      elsif request.start_date < self.start_date && self.end_date < request.end_date
        overlap << request
      end
    end
    overlap
  end

  def approved_overlapping_requests
      overlap = overlapping_requests
      if overlap.any?{|request| request.status == 'approved'}
        errors[:date] << "cannot overlap existing requests"
      end

    nil
  end

  def approve!

    ActiveRecord::Base.transaction do
      overlap = overlapping_requests
      overlap.each do |request|
        request.status = 'denied'
        request.save
      end
      self.status = 'approved'
      self.save
    end

  end

  def deny!
    self.status = 'denied'
    self.save

  end

  def pending?
    self.status == 'pending'
  end


end
