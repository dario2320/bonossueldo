class CreateBonoIndices < ActiveRecord::Migration[5.0]
  def change
    create_table :bono_indices do |t|
      t.string :anio
      t.string :mes
      t.string :dni
      t.integer :pagina
      t.string :archivo_name

      t.timestamps
    end
  end
end
