class AddPimageToSlitlamptb < ActiveRecord::Migration
  def self.up
    add_column :slitlamptbs, :pimage_file_name, :string
    add_column :slitlamptbs, :pimage_content_type, :string
    add_column :slitlamptbs, :pimage_image_size, :integer
  end

  def self.down
    remove_column :slitlamptbs, :pimage_image_size
    remove_column :slitlamptbs, :pimage_content_type
    remove_column :slitlamptbs, :pimage_file_name
  end
end
