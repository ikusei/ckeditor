class CreateCkeditorAssets < ActiveRecord::Migration
  def self.up
    create_table :ckeditor_assets do |t|
      t.string  :image_file_name, :null => false
      t.string  :image_content_type
      t.integer :image_file_size

      t.integer :attachable_id
      t.string  :attachable_type, :limit => 30
      t.string  :type, :limit => 30

      # Uncomment	it to save images dimensions, if your need it
      t.integer :width
      t.integer :height

      t.timestamps
    end

    add_index "ckeditor_assets", ["attachable_type", "type", "attachable_id"], :name => "idx_ckeditor_attachable_type"
    add_index "ckeditor_assets", ["attachable_type", "attachable_id"], :name => "idx_ckeditor_attachable"
  end

  def self.down
    drop_table :ckeditor_assets
  end
end
