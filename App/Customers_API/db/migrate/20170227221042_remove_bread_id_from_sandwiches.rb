class RemoveBreadIdFromSandwiches < ActiveRecord::Migration[5.0]
  def change
    remove_reference :sandwiches, :bread, foreign_key: true
  end
end
