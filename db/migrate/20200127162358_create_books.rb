class CreateBooks < ActiveRecord::Migration[5.2]
  def change
  	enable_extension 'hstore' unless extension_enabled?('hstore')
    create_table :books do |t|
      t.string :title
      t.string :tags, array: true
      t.string :ratings, array: true
      t.timestamps
    end
  end
end