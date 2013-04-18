class CreateEchonestApis < ActiveRecord::Migration
  def change
    create_table :echonest_apis do |t|

      t.timestamps
    end
  end
end
