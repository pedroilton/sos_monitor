class ClassMonitorsController < ApplicationController
  before_action :set_class_monitor, only: %i[destroy edit update destroy_schedule]
  after_action :authorize_class_monitor, except: :destroy

  def create
    @university_class = UniversityClass.find(params[:university_class_id])
    @class_monitor = ClassMonitor.create(student: User.find(params[:class_monitor][:student]),
                                         university_class: @university_class)
    redirect_to @university_class
  end

  def destroy
    @university_class = @class_monitor.university_class
    authorize @class_monitor
    @class_monitor.destroy
    redirect_to @university_class
  end

  # Envia um json com as monitorias do dia do monitor
  def monitor_day
    @class_monitor = User.find(params[:id]).class_monitors.last
    @monitorings = @class_monitor.monitorings.select do |monitoring|
      monitoring.date_time.strftime("%d/%m/%Y") == params[:date]
    end
    disciplines = @monitorings.map { |monitoring| monitoring.class_monitor.university_class.discipline }
    users = @monitorings.map(&:students)
    respond_to do |format|
      format.json { render json: { monitorings: @monitorings, disciplines: disciplines, users: users } }
    end
  end

  # Pagina da edicao de horarios do monitor
  def edit
    @week_monitorings = @class_monitor.monitorings.select do |monitoring|
      monitoring.date_time >= Date.today && monitoring.date_time <= Date.today + 7
    end
    @day_order = %w[sun mon tue wed thu fri sat]
    @portuguese_days = %w[Domingo Segunda-feira Terça-feira Quarta-feira Quinta-feira Sexta-feira Sábado]
  end

  def update
    @day_order = %w[sun mon tue wed thu fri sat]
    @portuguese_days = %w[Domingo Segunda-feira Terça-feira Quarta-feira Quinta-feira Sexta-feira Sábado]
    days = (Date.today..AcademicYear.where(['start_date < ? and end_date > ?', Date.today, Date.today]).first.end_date)
    days = days.to_a
    days.select! do |day|
      @portuguese_days[@day_order.index(day.strftime("%a").downcase)] == params[:schedule][:week_day]
    end
    days.each do |date|
      params[:schedule][:duration].to_i.times do |index|
        Monitoring.create(class_monitor: @class_monitor,
                          date_time: Time.zone.local_to_utc(date.to_time.change(
                                                              hour: params[:schedule]["time(4i)"].to_i + index,
                                                              min: params[:schedule]["time(5i)"].to_i
                                                            )))
      end
    end
    redirect_to edit_class_monitor_path(@class_monitor)
  end

  def destroy_schedule
    @day_order = %w[sun mon tue wed thu fri sat]
    @class_monitor.monitorings.select { |monitoring| monitoring.date_time > Date.today }.each do |monitoring|
      matches_week_day = @day_order.index(monitoring.date_time.strftime("%a").downcase) == params[:day].to_i
      if matches_week_day && monitoring.date_time.strftime('%H:%M') == params[:schedule].gsub(' ', '0')
        monitoring.destroy
      end
    end
    redirect_to edit_class_monitor_path(@class_monitor)
  end

  private

  def set_class_monitor
    @class_monitor = ClassMonitor.find(params[:id])
  end

  def authorize_class_monitor
    authorize @class_monitor
  end
end
