class AddTopicToComments < ActiveRecord::Migration
  def change
    add_column :comments, :topic_id, :integer
    add_index :comments, :topic_id
  end
end
