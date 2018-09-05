class TarefasController < ApplicationController
  before_action :set_tarefa, only: [:show, :edit, :update, :destroy]

  def finalizar
    @tarefa = Tarefa.find(params[:id])
    data_atual = DateTime.now
    
    respond_to do |format|
      if @tarefa.update(:finalizado => true, :data_finalizado => data_atual.strftime("%Y-%m-%d"))
        format.html { redirect_to action: "index" }
      end
    end
    
  end
  # GET /tarefas
  # GET /tarefas.json
  def index
    data_atual = DateTime.now

    @tarefas_finalizadas = Tarefa.where(user_id: current_user.id, finalizado: true)
    @tarefas_em_andamento = Tarefa.where("prazo >= '#{data_atual.strftime("%Y-%m-%d")}' and finalizado = false")
    @tarefas_em_atraso = Tarefa.where("prazo < '#{data_atual.strftime("%Y-%m-%d")}' and finalizado = false")
  end

  # GET /tarefas/1
  # GET /tarefas/1.json
  def show
  end

  # GET /tarefas/new
  def new
    @tarefa = Tarefa.new 
  end

  # GET /tarefas/1/edit
  def edit
  end

  # POST /tarefas
  # POST /tarefas.json
  def create
    
    @tarefa = Tarefa.new
    @tarefa.titulo = tarefa_params["titulo"]
    @tarefa.descricao = tarefa_params["descricao"]
    @tarefa.prazo =  params["tarefa"]["prazo"]
    @tarefa.user_id = current_user.id

    respond_to do |format|
      if @tarefa.save
        format.html { redirect_to @tarefa, notice: 'Tarefa was successfully created.' }
        format.json { render :show, status: :created, location: @tarefa }
      else
        format.html { render :new }
        format.json { render json: @tarefa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tarefas/1
  # PATCH/PUT /tarefas/1.json
  def update
    @tarefa = Tarefa.find(params[:id])
    titulo = params[:tarefa][:titulo]
    descricao = params[:tarefa][:descricao]
    prazo = params[:tarefa][:prazo]

    respond_to do |format|
      if @tarefa.update(:titulo => titulo, :descricao => descricao, :prazo => prazo)
        format.html { redirect_to @tarefa, notice: 'Tarefa was successfully updated.' }
        format.json { render :show, status: :ok, location: @tarefa }
      else
        format.html { render :edit }
        format.json { render json: @tarefa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tarefas/1
  # DELETE /tarefas/1.json
  def destroy
    @tarefa.destroy
    respond_to do |format|
      format.html { redirect_to tarefas_url, notice: 'Tarefa was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tarefa
      @tarefa = Tarefa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tarefa_params
      params.require(:tarefa).permit(:titulo, :descricao, :user_id)
    end
end
