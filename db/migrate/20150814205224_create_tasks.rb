class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :content
      t.integer :project_id
      t.boolean :done
      t.integer :position

      t.timestamps null: false
    end
  end
end
