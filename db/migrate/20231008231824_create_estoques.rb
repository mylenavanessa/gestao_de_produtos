class CreateEstoques < ActiveRecord::Migration[5.1]
  def change
    create_table :estoques do |t|
      t.string :tipo
      t.integer :quantidade
      t.references :produto, foreign_key: true

      t.timestamps
    end
  end
end
