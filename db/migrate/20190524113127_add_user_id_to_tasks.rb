class AddUserIdToTasks < ActiveRecord::Migration[5.2]
  def change
    t.references :user, foreign_key: true

  end
end
