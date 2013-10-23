class AddHotToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :hot, :integer, default: 0

    Node.reset_column_information
    Topic.all.each do |t|
      t.node.hot += t.replies.size + 1
      t.node.save
    end
  end
end
