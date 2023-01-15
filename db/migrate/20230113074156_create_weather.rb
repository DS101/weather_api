class CreateWeather < ActiveRecord::Migration[6.0]
  def change
    create_table :weathers do |t|
      t.decimal :temperature, precision: 5, scale: 2
      t.datetime :time

      t.timestamps
    end
  end
end
