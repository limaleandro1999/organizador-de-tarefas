class AddPrazoEDataFinalizadoTarefas < ActiveRecord::Migration[5.2]
  def change
    add_column :tarefas, :prazo, :date
    add_column :tarefas, :data_finalizado, :date, :default => ''
  end
end
