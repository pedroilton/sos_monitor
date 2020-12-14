class MonitoringsController < ApplicationController
  before_action :set_monitoring, only: %i[show edit schedule destroy cancel]
  after_action :authorize_monitoring, except: %i[index list monitoring_days destroy old_index old_list]

  # Lista de monitorias agendadas do aluno
  def index
    @monitorings = policy_scope(Monitoring).select do |monitoring|
      monitoring.students.include?(current_user) && monitoring.date_time >= Time.now
    end
    @monitorings.sort_by!(&:date_time)
  end

  # Lista de monitorias agendadas do aluno
  def old_index
    @monitorings = policy_scope(Monitoring).select do |monitoring|
      monitoring.students.include?(current_user) && monitoring.date_time < Time.now
    end
    @monitorings.sort_by!(&:date_time)
  end

  # Lista de monitorias futuras do monitor
  def list
    @monitorings = policy_scope(Monitoring).select do |monitoring|
      monitoring.class_monitor.student == current_user && monitoring.date_time >= Time.now
    end
    @monitorings.sort_by!(&:date_time)
  end

  # Lista de monitorias futuras do monitor
  def old_list
    @monitorings = policy_scope(Monitoring).select do |monitoring|
      monitoring.class_monitor.student == current_user && monitoring.date_time < Time.now
    end
    @monitorings.sort_by!(&:date_time)
  end

  def show
    @monitoring = Monitoring.find(params[:id])
    classes = @monitoring.class_monitor.university_class.discipline.university_classes.select do |university_class|
      university_class.academic_year ==
        AcademicYear.where(['start_date < ? and end_date > ?', Date.today, Date.today]).first
    end
    @students = classes.map(&:classes_students).flatten.map(&:student).reject do |student|
      @monitoring.students.include? student
    end
    @students.sort_by!(&:name)
    @monitorings_student = MonitoringsStudent.new
  end

  # Usado pelo ajax para filtrar as monitorias por horario
  def monitoring_days
    @monitorings = available_monitorings(Discipline.find(params[:discipline_id]))
    monitors = @monitorings.map(&:class_monitor)
    users = @monitorings.map { |monitoring| monitoring.class_monitor.student }
    respond_to { |format| format.json { render json: { monitorings: @monitorings, monitors: monitors, users: users } } }
  end

  def edit
    @monitorings = available_monitorings(@monitoring.class_monitor.university_class.discipline)
    @monitorings << @monitoring
    @monitorings.sort_by!(&:date_time)

    @other_dates = @monitorings.map { |monitoring| monitoring.date_time.strftime("%d/%m/%Y") }.uniq
    @other_dates.reject! { |date| date == @monitoring.date_time.strftime("%d/%m/%Y") }

    @day_monitorings = @monitorings.select do |monitoring|
      monitoring.date_time.strftime("%d/%m/%Y") == @monitoring.date_time.strftime("%d/%m/%Y")
    end
  end

  # Atualizacao de data/hora e duvida
  def update
    new_monitoring = Monitoring.find(params[:id])
    @monitoring = Monitoring.find(params[:old_monitoring_id])

    # Trocando horarios
    date_time = @monitoring.date_time
    @monitoring.date_time = new_monitoring.date_time
    new_monitoring.date_time = date_time

    # Trocando monitores
    class_monitor = @monitoring.class_monitor
    @monitoring.class_monitor = new_monitoring.class_monitor
    new_monitoring.class_monitor = class_monitor

    @monitoring.save
    new_monitoring.save

    if @monitoring.update(monitoring_params)
      redirect_to @monitoring
    else
      render :edit
    end
  end

  # Agendamento de monitoria
  def schedule
    MonitoringsStudent.create(student: current_user, monitoring: @monitoring)
    if @monitoring.update(monitoring_params)
      redirect_to @monitoring
    else
      render :edit
    end
  end

  def destroy
    @monitoring.question = ''
    @monitoring.save
    authorize @monitoring
    @monitoring.monitorings_students.each(&:destroy)
    redirect_to monitorings_path
  end

  def cancel
    if @monitoring.update(monitoring_params)
      redirect_to @monitoring
    else
      render :show
    end
  end

  private

  def available_monitorings(discipline)
    @monitorings = policy_scope(Monitoring).reject do |monitoring|
      monitoring.students.include?(current_user) || monitoring.class_monitor.student == current_user
    end
    @monitorings.select! do |monitoring|
      monitoring.class_monitor.university_class.discipline == discipline && monitoring.date_time > Time.now
    end
    @monitorings.sort_by(&:date_time)
  end

  def set_monitoring
    @monitoring = Monitoring.find(params[:id])
  end

  def monitoring_params
    params.require(:monitoring).permit(:monitor, :question, :place, :excuse, :date_time)
  end

  def authorize_monitoring
    authorize @monitoring
  end
end
