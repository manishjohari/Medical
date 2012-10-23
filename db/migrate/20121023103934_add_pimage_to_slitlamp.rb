class AddPimageToSlitlamp < ActiveRecord::Migration
  def self.up
    add_column :slitlamps, :pimage_file_name, :string
    add_column :slitlamps, :pimage_content_type, :string
    add_column :slitlamps, :pimage_file_size, :integer
  end

  def self.down
    remove_column :slitlamps, :pimage_file_size
    remove_column :slitlamps, :pimage_content_type
    remove_column :slitlamps, :pimage_file_name
  end
end
