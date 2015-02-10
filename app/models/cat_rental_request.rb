class CatRentalRequest < ActiveRecord::Base
  STATUS = ['pending', 'approved', 'denied']

  validates :cat_id, :start_date, :end_date, :status, presence: true



  belongs_to(:cat,
      :class_name => "Cat",
      :foreign_key => :cat_id,
      :primary_key => :id,
      :dependant => :destroy
      )




end
