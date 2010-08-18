class RemoveDateCreatedFromUpload < ActiveRecord::Migration
  def self.up
    remove_column :uploads, :date_created
  end

  def self.down
    add_column :uploads, :date_created, :datetime
  end
end
