class CreateSongKickApis < ActiveRecord::Migration
  def change
    create_table :song_kick_apis do |t|
      t.integer :metro_area_id

      t.timestamps
    end
  end
end
