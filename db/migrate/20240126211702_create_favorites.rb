class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
    #esto creara un indice en la tabla favorites ppara los user_id y los product_id
    
    add_index :favorites, [:user_id,:product_id],unique: true
  end
end
