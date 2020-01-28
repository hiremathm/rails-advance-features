class AddColumnPayloadToBook < ActiveRecord::Migration[5.2]
  def change
  	add_column :books, :payload, :json
  	add_column :books, :publisher, :jsonb
  end
end
