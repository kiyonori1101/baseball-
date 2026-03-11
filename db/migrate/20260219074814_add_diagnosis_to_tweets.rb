class AddDiagnosisToTweets < ActiveRecord::Migration[8.1]
  def change
    add_column :tweets, :question, :string
    add_column :tweets, :result, :string
  end
end
