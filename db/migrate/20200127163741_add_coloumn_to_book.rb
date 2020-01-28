class AddColoumnToBook < ActiveRecord::Migration[5.2]
  def change
  	add_column :books, :history, :hstore 
  end
end
