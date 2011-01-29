class CreateSiteTracks < ActiveRecord::Migration
  def self.up
    create_table :site_tracks , :id => false , :primary_key => :created_at do |t|
      t.integer :speed , :http_status_code
      t.belongs_to :site
      t.timestamps
    end
  end

  def self.down
    drop_table :site_tracks
  end
end
