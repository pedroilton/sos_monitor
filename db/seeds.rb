# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

puts 'Destroying ClassesStudent'
ClassesStudent.destroy_all
puts 'Destroying MonitoringsStudent'
MonitoringsStudent.destroy_all
puts 'Destroying Monitoring'
Monitoring.destroy_all
puts 'Destroying ClassMonitor'
ClassMonitor.destroy_all
puts 'Destroying AcademicYear'
AcademicYear.destroy_all
puts 'Destroying UniversityClass'
UniversityClass.destroy_all
puts 'Destroying Discipline'
Discipline.destroy_all
puts 'Destroying User'
User.destroy_all

puts 'Creating AcademicYear'
academic_year = AcademicYear.create(title: '2020/1', start_date: Date.parse('01-01-2020'),
                                    end_date: Date.parse('30-06-2020'))
puts academic_year.title
academic_year = AcademicYear.create(title: '2020/2', start_date: Date.parse('01-07-2020'),
                                    end_date: Date.parse('31-12-2020'))
puts academic_year.title
academic_year = AcademicYear.create(title: '2021/1', start_date: Date.parse('01-01-2021'),
                                    end_date: Date.parse('30-06-2021'))
puts academic_year.title

csv_options = { col_sep: ';', headers: :first_row }

puts 'Creating Discipline'
CSV.foreach('storage/seeds/disciplines.csv', csv_options) do |row|
  discipline = Discipline.create(title: row['title'], code: row['code'])
  puts discipline.title
end

puts 'Creating Demilson'
User.create(name: 'Demilson Nascimento',
            registration: '111',
            email: 'demilson@email.com',
            password: '123456',
            student: true,
            nickname: 'Demilson',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}")
User.create(name: 'Demilson Nascimento',
            registration: '211',
            email: 'demilson@email.com',
            password: '123456',
            professor: true,
            nickname: 'Demilson',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}")
User.create(name: 'Demilson Nascimento',
            registration: '311',
            email: 'demilson@email.com',
            password: '123456',
            admin: true,
            nickname: 'Demilson',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}")

puts 'Creating Eduardo'
User.create(name: 'Eduardo Ritter',
            registration: '122',
            email: 'eduardo@email.com',
            password: '123456',
            student: true,
            nickname: 'Eduardo',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}")
User.create(name: 'Eduardo Ritter',
            registration: '222',
            email: 'eduardo@email.com',
            password: '123456',
            professor: true,
            nickname: 'Eduardo',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}")
User.create(name: 'Eduardo Ritter',
            registration: '322',
            email: 'eduardo@email.com',
            password: '123456',
            admin: true,
            nickname: 'Eduardo',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}")

puts 'Creating Uellington'
User.create(name: 'Uellington Cortes',
            registration: '133',
            email: 'uellington@email.com',
            password: '123456',
            student: true,
            nickname: 'Uellington',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}")
User.create(name: 'Uellington Cortes',
            registration: '233',
            email: 'uellington@email.com',
            password: '123456',
            professor: true,
            nickname: 'Uellington',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}")
User.create(name: 'Uellington Cortes',
            registration: '333',
            email: 'uellington@email.com',
            password: '123456',
            admin: true,
            nickname: 'Uellington',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}")

puts 'Creating Pedro'
User.create(name: 'Pedro Ilton',
            registration: '144',
            email: 'pedro@email.com',
            password: '123456',
            student: true,
            nickname: 'Pedro',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}")
User.create(name: 'Pedro Ilton',
            registration: '244',
            email: 'pedro@email.com',
            password: '123456',
            professor: true,
            nickname: 'Pedro',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}")
User.create(name: 'Pedro Ilton',
            registration: '344',
            email: 'pedro@email.com',
            password: '123456',
            admin: true,
            nickname: 'Pedro',
            phone_number: "(#{rand(10..99)}) #{rand(1_000..99_999)}-#{rand(1_000..9_999)}")

puts 'Creating Users'
CSV.foreach('storage/seeds/users.csv', csv_options) do |row|
  user = User.create(name: row['name'], registration: row['registration'],
                     nickname: row['nickname'], password: row['password'],
                     email: row['email'])
  user.professor = true if row['professor'] == 'true'
  user.admin = true if row['admin'] == 'true'
  user.save
  puts user.name
end

puts 'Creating Students'
CSV.foreach('storage/seeds/students.csv', csv_options) do |row|
  user = User.create(name: row['name'], registration: row['registration'],
                     password: row['password'], email: row['email'], student: true)
  puts user.name
end

puts 'Creating Classes'
CSV.foreach('storage/seeds/classes.csv', csv_options) do |row|
  university_class = UniversityClass.create(title: row['title'], discipline: Discipline.find_by(code: row['discipline']),
                                            professor: User.find_by(registration: row['professor']),
                                            academic_year: AcademicYear.where(['start_date < ? and end_date > ?',
                                                                               Date.today, Date.today]).first)
  puts university_class.title
end

monitor_class = UniversityClass.where(['title < ? and discipline_id > ?',
                                       'T', Discipline.find_by(code: '108208160')]).first

puts 'Creating ClassMonitor'
3.times do
  class_monitor = ClassMonitor.create(student: User.select(&:student?).sample, university_class: monitor_class)
  puts class_monitor.student.name
end

puts 'Creating ClassesStudent'
User.select { |user| user.student? && !user.monitor? }.first(30).each do |student|
  classes_student = ClassesStudent.create(student: student, university_class: monitor_class)
  puts classes_student.student.name
end

User.select(&:student?).each do |student|
  5.times do
    classes_student = ClassesStudent.create(student: student, university_class: UniversityClass.all.reject do |uclass|
      uclass == monitor_class
    end.sample)
    puts classes_student.student.name
  end
end

schedule = { mon: [{ start: DateTime.strptime('12:00', '%H:%M'), duration: 2 },
                   start: DateTime.strptime('18:30', '%H:%M'), duration: 1],
             tue: [{ start: DateTime.strptime('08:00', '%H:%M'), duration: 4 }],
             wed: [],
             thu: [{ start: DateTime.strptime('13:00', '%H:%M'), duration: 1 }],
             fri: [],
             sat: [],
             sun: [] }

puts 'Creating Monitorings'
ClassMonitor.all.each do |class_monitor|
  ((Date.today - 7)..AcademicYear.where(['start_date < ? and end_date > ?', Date.today, Date.today]).first.end_date)
    .each do
    |date|
    schedule[date.strftime("%a").downcase.to_sym].each do |monitoring_session|
      index = 0
      monitoring_session[:duration].times do
        monitoring = Monitoring.create(
          class_monitor: class_monitor,
          place: "Sala #{rand(1..30)}",
          date_time: DateTime.parse(date.strftime("%Y-%m-%dT#{(monitoring_session[:start] + index.hours)
            .strftime('%H:%M')}:00%z"))
        )
        puts monitoring.date_time
        index += 1
      end
    end
  end
end

puts 'Creating MonitoringsStudent'
monitoring = Monitoring.first
monitoring.question = 'Como faz alguma coisa?'
monitoring.save
3.times do
  monitorings_student = MonitoringsStudent.create(monitoring: Monitoring.first, student: User.select(&:student?).sample)
  puts monitorings_student.student.name
end
