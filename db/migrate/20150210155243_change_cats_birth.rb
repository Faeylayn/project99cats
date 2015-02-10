class ChangeCatsBirth < ActiveRecord::Migration
  def change
    remove_column :cats, :birth_date, :string
    add_column :cats, :birth_date, :datetime
  end
end
