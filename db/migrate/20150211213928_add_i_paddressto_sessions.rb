class AddIPaddresstoSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :current_ip_address, :string

  end
end
