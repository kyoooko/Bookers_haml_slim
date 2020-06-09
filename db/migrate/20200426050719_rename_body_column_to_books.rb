class RenameBodyColumnToBooks < ActiveRecord::Migration[5.2]
  def change
    rename_column :books, :body, :opinion
  end
end
