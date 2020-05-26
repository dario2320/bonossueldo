class ChangeUsernameToUsers < ActiveRecord::Migration[5.0]
  
  	def change
  	change_table :users do |t|
      t.change :username, :string, null: false, :default => ""
  end
  
  end
end
