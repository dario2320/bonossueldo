class CreateEmpleados < ActiveRecord::Migration[5.0]
  def change
    create_table :empleados do |t|
      t.string :legajo
      t.string :cuit
      t.string :nombre

      t.timestamps
    end
  end
end
