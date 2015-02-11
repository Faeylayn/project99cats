class AddEnvToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :current_env, :text
  end
end
