class CreateDiagnosticScreenerAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :diagnostic_screener_answers do |t|
      t.integer :value, null: false
      t.string :question_id, null: false
      t.check_constraint "value BETWEEN 0 AND 4", name: "btw_zero_and_four"
      t.timestamps
    end
  end
end
