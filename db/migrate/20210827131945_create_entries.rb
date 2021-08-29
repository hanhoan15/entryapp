class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
