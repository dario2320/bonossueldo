class ChangeColumn < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.change :dni, :string, null: false
  end
  end
end
