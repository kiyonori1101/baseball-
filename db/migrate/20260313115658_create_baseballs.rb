class CreateBaseballs < ActiveRecord::Migration[8.1]
  def change
    create_table :baseballs do |t|
      t.string :question

      t.timestamps
    end
  end
end
