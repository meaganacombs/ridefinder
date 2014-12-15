class AddCommentColumnToDrives < ActiveRecord::Migration
  def change
    add_column :drives, :comment, :text
  end
end
