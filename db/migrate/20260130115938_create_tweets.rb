class CreateTweets < ActiveRecord::Migration[8.1]
  def change
    create_table :tweets do |t|
      t.string :name
      t.integer :price
      t.text :review
      t.text :comment

      t.timestamps
    end
  end
end
