class ClassMonitorsController < ApplicationController
  def create
    @university_class = UniversityClass.find(params[:university_class_id])
    @class_monitor = ClassMonitor.create(student: User.find(params[:class_monitor][:student]),
                                         university_class: @university_class)
    redirect_to @university_class
    authorize @class_monitor
  end

  def destroy
    @class_monitor = ClassMonitor.find(params[:id])
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
    authorize @class_monitor
  end

  # Pagina da edicao de horarios do monitor
  def edit_schedule
    @class_monitor = ClassMonitor.find(params[:id])
    @week_monitorings = @class_monitor.monitorings.select do |monitoring|
      monitoring.date_time >= Date.today && monitoring.date_time <= Date.today + 7
    end
    @day_order = %w[sun mon tue wed thu fri sat]
    @portuguese_days = %w[Domingo Segunda-feira Terça-feira Quarta-feira Quinta-feira Sexta-feira Sábado]
    authorize @class_monitor
    # schedule = {}
    # @week_monitorings.each do |monitoring|
    #   schedule[monitoring.date_time.strftime("%a").downcase.to_sym] << monitoring.date_time
    # end
  end

  # schedule = { mon: [{ start: DateTime.strptime('12:00', '%H:%M'), duration: 2 },
  #                    start: DateTime.strptime('18:30', '%H:%M'), duration: 1],
  #              tue: [{ start: DateTime.strptime('08:00', '%H:%M'), duration: 4 }],
  #              wed: [],
  #              thu: [{ start: DateTime.strptime('13:00', '%H:%M'), duration: 1 }],
  #              fri: [],
  #              sat: [],
  #              sun: [] }

  # puts 'Creating Monitorings'
  # ClassMonitor.all.each do |class_monitor|
  #   ((Date.today - 7)..AcademicYear.where(['start_date < ? and end_date > ?', Date.today, Date.today]).first.end_date)
  #     .each do
  #     |date|
  #     schedule[date.strftime("%a").downcase.to_sym].each do |monitoring_session|
  #       index = 0
  #       monitoring_session[:duration].times do
  #         monitoring = Monitoring.create(
  #           class_monitor: class_monitor,
  #           place: "Sala #{rand(1..30)}",
  #           date_time: DateTime.parse(date.strftime("%Y-%m-%dT#{(monitoring_session[:start] + index.hours)
  #           .strftime('%H:%M')}:00%z"))
  #         )
  #         puts monitoring.date_time
  #         index += 1
  #       end
  #     end
  #   end
  # end
end
