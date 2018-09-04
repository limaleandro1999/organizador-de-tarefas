class AddFinalizadoToTarefas < ActiveRecord::Migration[5.2]
  def change
    add_column :tarefas, :finalizado, :boolean, :default => false
  end
end
