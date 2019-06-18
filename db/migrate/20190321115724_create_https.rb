class CreateHttps < ActiveRecord::Migration[5.2]
  def change
    create_table :https do |t|

      t.timestamps
    end
  end
end
