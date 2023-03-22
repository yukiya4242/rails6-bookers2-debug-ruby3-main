class RenameFolloewdIdColumnToRelationships < ActiveRecord::Migration[6.1]
  def change
    rename_column :relationships, :folloewd_id, :followed_id
  end
end
