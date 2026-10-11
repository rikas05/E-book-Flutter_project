class CreateEbooks < ActiveRecord::Migration[8.1]
  def change
    create_table :ebooks do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.text :description
      t.string :file_path, null: false
      t.bigint :file_size, null: false
      t.datetime :uploaded_at, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
    
    add_index :ebooks, :title
    add_index :ebooks, :author
    add_index :ebooks, :uploaded_at
  end
end
