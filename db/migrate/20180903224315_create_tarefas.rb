class CreateTarefas < ActiveRecord::Migration[5.2]
  def change
    create_table :tarefas do |t|
      t.string :titulo
      t.text :descricao
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
