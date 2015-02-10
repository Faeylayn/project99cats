class Cat < ActiveRecord::Base
  COLORS =
    ['red', 'black', 'white']



  validates :name, :color, :birth_date, :sex, :description, presence: true
  validates :color, :inclusion =>  COLORS
  validates :sex, :inclusion => ['M', 'F']

  has_many(:requests,
      :class_name => "CatRentalRequest",
      :foreign_key => :cat_id,
      :primary_key => :id

  )

  def age
    Time.now - self.birth_date

  end

end
