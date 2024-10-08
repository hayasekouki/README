class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :body, null: false #空にならないようにnull制約をfalseにする
      t.references :user, foreign_key: true
      t.references :board, foreign_key: true 

      t.timestamps
    end
  end
end
